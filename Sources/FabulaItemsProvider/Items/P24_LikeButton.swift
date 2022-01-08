//
//  P24_LikeButton.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P24_LikeButton: View {
    
    @State private var isSelected1: Bool = false
    @State private var isSelected2: Bool = false
    @State private var isSelected3: Bool = false
    @State private var isSelected4: Bool = false
    @State private var isSelected5: Bool = false
    @State private var isSelected6: Bool = false
    @State private var isSelected7: Bool = false
    @State private var isSelected8: Bool = false
    @State private var isSelected9: Bool = false
    
    @State private var isOpen: Bool = false
    
    @State private var scale: Double = 0.6
    @State private var normalColor: Color = Color.fabulaFore1
    @State private var selectColor: Color = Color.fabulaSecondary
    @State private var effectColor: Color = Color.fabulaSecondary
    
    let padingScale: CGFloat = 0.1
    
    public init() {}
    public var body: some View {
        GeometryReader{ proxy in
            ZStack {
                Color.clear
                VStack(spacing: proxy.minSize * padingScale) {
                    HStack(spacing: proxy.minSize * padingScale) {
                        FabulaLikeButton(isSelected: $isSelected1, normalColor: normalColor, selectColor: selectColor, effectColor: effectColor, systemNormalName: "heart", systemSelectName: "heart.fill")
                        Divider()
                        FabulaLikeButton(isSelected: $isSelected2, normalColor: normalColor, selectColor: selectColor, effectColor: effectColor, systemNormalName: "phone.circle", systemSelectName: "phone.circle.fill")
                        Divider()
                        FabulaLikeButton(isSelected: $isSelected3, normalColor: normalColor, selectColor: selectColor, effectColor: effectColor, systemNormalName: "cloud.heavyrain", systemSelectName: "cloud.heavyrain.fill")
                    }
                    Divider()
                    HStack(spacing: proxy.minSize * padingScale) {
                        FabulaLikeButton(isSelected: $isSelected4, normalColor: normalColor, selectColor: selectColor, effectColor: effectColor, systemNormalName: "moon.stars", systemSelectName: "moon.stars.fill")
                        Divider()
                        FabulaLikeButton(isSelected: $isSelected5, normalColor: normalColor, selectColor: selectColor, effectColor: effectColor, systemNormalName: "paperplane.circle", systemSelectName: "paperplane.circle.fill")
                        Divider()
                        FabulaLikeButton(isSelected: $isSelected6, normalColor: normalColor, selectColor: selectColor, effectColor: effectColor, systemNormalName: "hand.thumbsup", systemSelectName: "hand.thumbsup.fill")
                    }
                    Divider()
                    HStack(spacing: proxy.minSize * padingScale) {
                        FabulaLikeButton(isSelected: $isSelected7, normalColor: normalColor, selectColor: selectColor, effectColor: effectColor, systemNormalName: "circle", systemSelectName: "circle.fill")
                        Divider()
                        FabulaLikeButton(isSelected: $isSelected8, normalColor: normalColor, selectColor: selectColor, effectColor: effectColor, systemNormalName: "bolt.heart", systemSelectName: "bolt.heart.fill")
                        Divider()
                        FabulaLikeButton(isSelected: $isSelected9, normalColor: normalColor, selectColor: selectColor, effectColor: effectColor, systemNormalName: "star", systemSelectName: "star.fill")
                    }
                }
                .frame(width: proxy.size.width * scale, height: proxy.size.height * scale)
                
                
                
                FabulaSheet(isOpen: $isOpen) {
                    Text("Size").modifier(FabulaSectionModifier())
                    FabulaSlider(value: $scale, title: "Scale", min: 0.5, max: 0.8)
                    Text("Color").modifier(FabulaSectionModifier())
                    ColorPicker("Normal", selection: $normalColor)
                    ColorPicker("Selected", selection: $selectColor)
                    ColorPicker("Effect", selection: $effectColor)
                }
            }
        }
    }
}

fileprivate
struct BottomSheet<Content>: View where Content: View {
    @Binding var isOpen: Bool
    var constants: SheetConstants = SheetConstants()
    @ViewBuilder var content: () -> Content
    
    @GestureState private var translation: CGFloat = 0
    @State private var activeAnimation: Bool = false
    @State private var coverOpacity: CGFloat = 0
    
    private let limitDragGap: CGFloat = 120
    private var dragGesture: some Gesture {
        DragGesture().updating(self.$translation) { value, state, _ in
            guard abs(value.translation.width) < limitDragGap else { return }
            state = value.translation.height
        }
        .onChanged{ value in
            guard abs(value.translation.width) < limitDragGap else { return }
            let max = constants.maxArea - constants.minArea
            let delta = isOpen ? (value.translation.height) / max : 1 - ((value.translation.height * -1) / max)
            coverOpacity = delta > 1 ? 1 : (delta < 0 ? 0 : delta)
        }
        .onEnded { value in
            guard abs(value.translation.width) < limitDragGap else { return }
            self.isOpen = value.translation.height < 0
            coverOpacity = isOpen ? 0 : 1.0
        }
    }
    
    private var offset: CGFloat {
        isOpen ? 0 : constants.maxArea - constants.minArea
    }
    
    private var indicator: some View {
        ZStack {
            Rectangle()
                .fill(constants.indicatorBGColor)
#if os(iOS)
                .opacity(0.5)
                .background(.ultraThinMaterial)
#endif
                .frame(height: constants.minArea)
            Capsule()
                .fill(constants.indicatorColor)
                .frame(
                    width: constants.indicatorMax,
                    height: constants.indicatorMin
                )
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            constants.backgroundColor.opacity(constants.backgroundDisabled ? 0 : (1 - coverOpacity))
                .edgesIgnoringSafeArea(.all)
                .disabled(constants.backgroundDisabled || !isOpen)
                .animation(.default, value: constants.backgroundDisabled)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.isOpen = false
                        coverOpacity = 1.0
                    }
                }
            VStack(spacing: 0) {
                self.indicator
                    .clipShape(RoundedCorners(tl: constants.radius, tr: constants.radius))
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 0)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            self.isOpen.toggle()
                            coverOpacity = isOpen ? 0 : 1.0
                        }
                    }
                ZStack {
                    constants.contentBGColor
#if os(iOS)
                        .opacity(0.5)
                        .background(.ultraThinMaterial)
#endif
                        .clipped()
                        .edgesIgnoringSafeArea(.bottom)
                    self.content()
                    Rectangle()
                        .fill(constants.contentCoverColor)
                        .opacity(coverOpacity)
                        .disabled(true)
                }
            }
            .frame(width: geometry.size.width, height: constants.maxArea)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(activeAnimation ? .customSpring : nil, value: isOpen)
        }
        .highPriorityGesture(
            dragGesture
        )
        .onAppear {
            DispatchQueue.main.async {
                activeAnimation = true
                if isOpen {
                    coverOpacity = 0
                }else {
                    coverOpacity = 1
                }
            }
        }
    }
}

fileprivate
struct RoundedCorners: InsettableShape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.size.width
        let h = rect.size.height
        
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)
        
        path.move(to: CGPoint(x: w / 2.0 + insetAmount, y: insetAmount))
        path.addLine(to: CGPoint(x: w - tr + insetAmount, y: insetAmount))
        path.addArc(center: CGPoint(x: w - tr + insetAmount, y: tr + insetAmount), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: w + insetAmount, y: h - br + insetAmount))
        path.addArc(center: CGPoint(x: w - br + insetAmount, y: h - br + insetAmount), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: bl + insetAmount, y: h + insetAmount))
        path.addArc(center: CGPoint(x: bl + insetAmount, y: h - bl + insetAmount), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: insetAmount, y: tl + insetAmount))
        path.addArc(center: CGPoint(x: tl + insetAmount, y: tl + insetAmount), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        path.closeSubpath()
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var rectangle = self
        rectangle.insetAmount += amount
        return rectangle
    }
}

fileprivate
extension Animation {
    static var customSpring: Animation {
       self.spring(response: 0.28, dampingFraction: 0.8, blendDuration: 0.86)
    }
}

fileprivate
struct RightSheet<Content>: View where Content: View {
    @Binding var isOpen: Bool
    var constants: SheetConstants = SheetConstants()
    @ViewBuilder var content: () -> Content
    
    @GestureState private var translation: CGFloat = 0
    @State private var activeAnimation: Bool = false
    @State private var coverOpacity: CGFloat = 0
    
    private var dragGesture: some Gesture {
        DragGesture().updating(self.$translation) { value, state, _ in
            state = value.translation.width
        }
        .onChanged{ value in
            let max = constants.maxArea - constants.minArea
            let delta = isOpen ? (value.translation.width) / max : 1 - ((value.translation.width * -1) / max)
            coverOpacity = delta > 1 ? 1 : (delta < 0 ? 0 : delta)
        }
        .onEnded { value in
            self.isOpen = value.translation.width < 0
            coverOpacity = isOpen ? 0 : 1.0
        }
    }
    
    private var offset: CGFloat {
        isOpen ? 0 : constants.maxArea - constants.minArea
    }
    
    private var indicator: some View {
        ZStack {
            Rectangle()
                .fill(constants.indicatorBGColor)
#if os(iOS)
                .opacity(0.5)
                .background(.ultraThinMaterial)
#endif
                .frame(width: constants.minArea)
            Capsule()
                .fill(constants.indicatorColor)
                .frame(
                    width: constants.indicatorMin,
                    height: constants.indicatorMax
                )
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            constants.backgroundColor.opacity(constants.backgroundDisabled ? 0 : (1 - coverOpacity))
                .edgesIgnoringSafeArea(.all)
                .disabled(constants.backgroundDisabled || !isOpen)
                .animation(.default, value: constants.backgroundDisabled)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.isOpen = false
                        coverOpacity = 1.0
                    }
                }
            HStack(spacing: 0) {
                self.indicator
                    .clipShape(RoundedCorners(tl: constants.radius, bl: constants.radius))
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 0)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            self.isOpen.toggle()
                            coverOpacity = isOpen ? 0 : 1.0
                        }
                    }
                ZStack {
                    constants.contentBGColor
#if os(iOS)
                        .opacity(0.5)
                        .background(.ultraThinMaterial)
#endif
                        .clipped()
                        .edgesIgnoringSafeArea(.trailing)
                    self.content()
                    Rectangle()
                        .fill(constants.contentCoverColor)
                        .opacity(coverOpacity)
                        .disabled(true)
                }
            }
            .frame(width: constants.maxArea, height: geometry.size.height)
            .frame(width: geometry.size.width, alignment: .trailing)
            .offset(x: max(self.offset + self.translation, 0))
            .animation(activeAnimation ? .customSpring : nil, value: isOpen)
        }
        .highPriorityGesture( // 하위 onTapGesture 제스처보다 우선순위를 높이기 위해 highPriorityGesture 사용
            dragGesture
        )
        .onAppear {
            DispatchQueue.main.async {
                activeAnimation = true
                if isOpen {
                    coverOpacity = 0
                }else {
                    coverOpacity = 1
                }
            }
        }
    }
}

fileprivate
struct SheetConstants {
    var minArea: CGFloat = 36
    var maxArea: CGFloat = 200
    var radius: CGFloat = 12
    
    var backgroundDisabled: Bool = true
    var backgroundColor: Color = Color.black.opacity(0.1)
    
    var contentCoverColor: Color = Color.white
    var contentBGColor: Color = Color.white
    
    var indicatorMin: CGFloat = 4
    var indicatorMax: CGFloat = 34
    var indicatorColor: Color = Color.black
    var indicatorBGColor: Color = Color.gray
}

fileprivate
struct FabulaLikeEffect: View {
    
    @Binding var scale: CGFloat
    var tickCount = 7
    var size: CGFloat = 3
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                ForEach(0..<tickCount) { tick in
                    Circle()
                        .scaleEffect(scale)
                        .animation(scale != 1 ? Animation.easeInOut(duration: 0.8) : Animation.easeInOut(duration: 0), value: scale)
                        .frame(width: size, height: size)
                        .offset(x: proxy.size.width <= proxy.size.height ? -(proxy.size.width / 2) : -(proxy.size.height / 2 ))
                        .rotationEffect(.degrees(Double(tick) / Double(tickCount)) * 360)
                        .offset(x: -size/2, y: -size/2)
                    
                }
            }
            .offset(x: proxy.size.width / 2, y: proxy.size.height / 2)
        }
    }
}

fileprivate
struct FabulaLikeButton: View {
    
    @Binding var isSelected: Bool
    var normalColor: Color = Color.fabulaFore1
    var selectColor: Color = Color.fabulaPrimary
    var effectColor: Color = Color.fabulaPrimary
    var systemNormalName: String = "heart"
    var systemSelectName: String = "heart.fill"
    var action: ((Bool) -> Void)?
    
    @State private var scaleSmall: CGFloat = 0.0001
    @State private var scaleLarge: CGFloat = 0.0001
    @State private var scaleCircle: CGFloat = 0.0001
    @State private var isActiveAni: Bool = false
    
    var body: some View {
        GeometryReader{ proxy in
            ZStack {
                Color.clear
                ZStack {
                    Image(systemName: systemNormalName)
                        .font(.system(size: proxy.minSize))
                        .opacity(isSelected ? 0 : 1)
                        .scaleEffect(isSelected ? 0.0001 : 1)
                        .foregroundColor(normalColor)
                        .animation(isSelected && isActiveAni ? Animation.easeOut(duration: 0) : Animation.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.8), value: isSelected)
                    Image(systemName: systemSelectName)
                        .font(.system(size: proxy.minSize))
                        .opacity(isSelected ? 1 : 0)
                        .scaleEffect(isSelected ? 1 : 0.0001)
                        .foregroundColor(isSelected ? selectColor : Color.clear)
                        .animation(isSelected && isActiveAni ? Animation.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.8).delay(0.2) : Animation.easeOut(duration: 0), value: isSelected)
                    Circle()
                        .strokeBorder(style: StrokeStyle(lineWidth: isSelected ? 0 : proxy.minSize / 2))
                        .foregroundColor(isSelected ? selectColor : normalColor)
                        .scaleEffect(scaleCircle)
                        .opacity(isSelected ? 1 : 0)
                        .animation(isSelected ? Animation.easeOut(duration: 0.31) : Animation.easeOut(duration: 0), value: isSelected)
                    
                    ZStack {
                        FabulaLikeEffect(scale: $scaleSmall, tickCount: 7, size: proxy.minSize * 0.08)
                            .foregroundColor(isSelected ? effectColor : normalColor)
                            .scaleEffect(isSelected ? 1.6 : 0.0001)
                            .opacity(isSelected ? 1 : 0)
                            .rotationEffect(isSelected ? Angle(degrees: 6) : Angle(degrees: 24))
                            .animation(isSelected ? Animation.customSpring.delay(0.10) : Animation.easeOut(duration: 0), value: isSelected)
                        
                        FabulaLikeEffect(scale: $scaleLarge, tickCount: 7, size: proxy.minSize * 0.1)
                            .foregroundColor(isSelected ? effectColor : normalColor)
                            .scaleEffect(isSelected ? 2 : 0.0001)
                            .opacity(isSelected ? 1 : 0)
                            .animation(isSelected ? Animation.customSpring.delay(0.16) : Animation.easeOut(duration: 0), value: isSelected)
                        
                    }
                }
                .animation(Animation.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.8), value: isSelected)
                .frame(width: proxy.minSize, height: proxy.minSize, alignment: .center)
                
            }
            .onTapGesture {
                isActiveAni = true
                withAnimation(Animation.spring(response: 0.34, dampingFraction: 0.6, blendDuration: 0.8)) {
                    isSelected.toggle()
                    action?(isSelected)
                    if isSelected {
                        self.scaleSmall = 1.0
                        self.scaleLarge = 1.0
                        self.scaleCircle = 1.6
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.scaleSmall = 0.0001
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.scaleLarge = 0.0001
                        }
                    }else {
                        self.scaleSmall = 0.0001
                        self.scaleLarge = 0.0001
                        self.scaleCircle = 0.0001
                    }
                }
            }
        }
    }
}

fileprivate
struct FabulaSlider: View {
    @Binding var value: Double
    var title: String = ""
    var min: CGFloat = 0
    var max: CGFloat = 100
    var onEditingChanged: (Bool) -> Void = { _ in }
    
    var body: some View {
        HStack {
            Text(title)
            ZStack {
                HStack {
                    ZStack {
                        Slider(value: $value, in: min...max) { value in
                            onEditingChanged(value)
                        }
                    }
                    Text("\(String(format: "%.1f", value))")
                        .font(.body)
                }
            }
        }
    }
}

fileprivate
struct FabulaSectionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(Color.fabulaFore1.opacity(0.5))
            .frame(height: 32)
    }
}

fileprivate
struct FabulaSheet<Content>: View where Content: View {
    @Binding var isOpen: Bool
#if os(iOS)
    @Environment(\.verticalSizeClass) private var verticalSizeClass
#endif
    var constants: SheetConstants {
        SheetConstants(
            minArea: 38,
            maxArea: 270,
            radius: 16,
            
            backgroundDisabled: false,
            backgroundColor: Color.black.opacity(0.12),
            
            contentCoverColor: Color.fabulaBack0,
            contentBGColor: Color.fabulaBar2.opacity(0.9),
            
            indicatorMin: 4,
            indicatorMax: 34,
            indicatorColor: Color.fabulaPrimary,
            indicatorBGColor: Color.fabulaBar1.opacity(0.9)
        )
    }
    
    var constants2: SheetConstants {
        SheetConstants(
            minArea: 38,
            maxArea: 300,
            radius: 16,
            
            backgroundDisabled: false,
            backgroundColor: Color.black.opacity(0.12),
            
            contentCoverColor: Color.fabulaBack0,
            contentBGColor: Color.fabulaBar2.opacity(0.9),
            
            indicatorMin: 4,
            indicatorMax: 34,
            indicatorColor: Color.fabulaPrimary,
            indicatorBGColor: Color.fabulaBar1.opacity(0.9)
        )
    }
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
#if os(iOS)
            ZStack {
                if isPad {
                    RightSheet(isOpen: $isOpen, constants: constants2) {
                        getContent()
                    }
                }else {
                    if verticalSizeClass == .regular {
                        BottomSheet(isOpen: $isOpen, constants: constants) {
                            getContent()
                        }
                    }else {
                        RightSheet(isOpen: $isOpen, constants: constants2) {
                            getContent()
                        }
                    }
                }
            }
#else
            RightSheet(isOpen: $isOpen, constants: constants2) {
                getContent()
            }
#endif
        }
    }
    
    private func getContent() -> some View {
        VStack(alignment: .leading) {
            self.content()
            Spacer()
        }
        .padding(26)
    }
}

struct P24_LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        P24_LikeButton()
    }
}
