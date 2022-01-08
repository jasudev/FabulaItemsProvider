//
//  P17_Pyramid.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P17_Pyramid: View {
    
    @State private var isOpen: Bool = false
    
    @State private var percentage1: Double = 10
    @State private var percentage2: Double = 40
    @State private var percentage3: Double = 74
    
#if os(iOS)
    let hspacing: CGFloat = 25
#else
    let hspacing: CGFloat = 50
#endif
    
    let colors = [Color(hex: 0xC6D2BE), Color(hex: 0x83B1C9), Color(hex: 0xEFBAD6)]
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                HStack(alignment: .bottom, spacing: hspacing) {
                    PyramidGraphView(percentage: $percentage1,
                                     color: percentage1 != 0 ? colors[0] : Color.gray.opacity(0.3),
                                     size: CGSize(width: getWidth(proxy), height: getWidth(proxy) / 2 + (proxy.size.height / 3) * (CGFloat(percentage1) * 0.01)))
                    PyramidGraphView(percentage: $percentage2,
                                     color: percentage2 != 0 ? colors[1] : Color.gray.opacity(0.3),
                                     size: CGSize(width: getWidth(proxy), height: getWidth(proxy) / 2 + (proxy.size.height / 3) * (CGFloat(percentage2) * 0.01)))
                    PyramidGraphView(percentage: $percentage3,
                                     color: percentage3 != 0 ? colors[2] : Color.gray.opacity(0.3),
                                     size: CGSize(width: getWidth(proxy), height: getWidth(proxy) / 2 + (proxy.size.height / 3) * (CGFloat(percentage3) * 0.01)))
                }
                .animation(Animation.easeOut(duration: 0.1), value: percentage1)
                .animation(Animation.easeOut(duration: 0.1), value: percentage2)
                .animation(Animation.easeOut(duration: 0.1), value: percentage3)
                
                FabulaSheet(isOpen: $isOpen) {
                    Text("Graph").modifier(FabulaSectionModifier())
                    FabulaSlider(value: $percentage1.animation(), title: "1", min: 0, max: 100)
                    FabulaSlider(value: $percentage2.animation(), title: "2", min: 0, max: 100)
                    FabulaSlider(value: $percentage3.animation(), title: "3", min: 0, max: 100)
                }
            }
        }
    }
    
    private func getWidth(_ proxy: GeometryProxy) -> CGFloat {
#if os(iOS)
        let maxWidth: CGFloat = 150
#else
        let maxWidth: CGFloat = 300
#endif
        
        var width = round((proxy.size.width - (30 * 5)) / 3)
        width = width > maxWidth ? maxWidth : width
        return width
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
struct PyramidGraphView: View {
    
    @Binding var percentage: Double
    var color: Color
    var size : CGSize
    
    var body: some View {
        VStack(spacing: 22) {
            getTopInfo(color: color)
            PyramidView(color: color)
                .modifier(GuideLineModifier(direction: .height(.trailing), color: Color.fabulaFore1.opacity(0.16)))
                .modifier(GuideLineModifier(direction: .width(.bottom), color: Color.fabulaFore1.opacity(0.16)))
                .frame(width: size.width, height: size.height)
            getBottomInfo(color: color)
        }
    }
    
    private func getTopInfo(color: Color) -> some View {
        HStack(alignment: .top, spacing: 5) {
            VStack(alignment: .trailing, spacing: 4) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(color)
                    .frame(width: 15, height: 15)
                Text("eijf")
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(color)
                    .font(.system(size: 15))
            }
            .frame(width: 40, alignment: .trailing)
            .redacted(reason: [.placeholder])
            
            Rectangle()
                .fill(Color.fabulaFore1.opacity(0.8))
                .frame(width: 1)
                .frame(maxHeight: 100)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(Int(percentage))%")
                    .foregroundColor(Color.fabulaFore1)
                    .font(.custom("Helvetica Bold", fixedSize: 18))
                    .fontWeight(.bold)
                Text("fejwifjewif fj")
                    .font(.system(size: 11))
                    .offset(y: -2)
                    .redacted(reason: [.placeholder])
            }
            .offset(y: -3)
            .frame(width: 40)
        }
    }
    
    private func getBottomInfo(color: Color) -> some View {
        HStack(alignment: .bottom, spacing: 5) {
            Text("eijf")
                .multilineTextAlignment(.trailing)
                .offset(y: 2)
                .foregroundColor(color)
                .font(.system(size: 15))
                .frame(width: 40, alignment: .trailing)
            Rectangle()
                .fill(Color.fabulaFore1.opacity(0.8))
                .frame(width: 1)
                .frame(maxHeight: 100)
            Text("fejwifjewif fjeiwjf fiewjfif")
                .font(.system(size: 11))
                .frame(width: 40)
        }
        .redacted(reason: [.placeholder])
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
                            vibration()
                        }
                    }
                    Text("\(String(format: "%.1f", value))")
                        .font(.body)
                }
            }
        }
    }
    
    func vibration() {
#if os(iOS)
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
#endif
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

fileprivate
enum GuideLineDirection {
    case width(VerticalAlignment)
    case height(HorizontalAlignment)
}

fileprivate
enum GuideLinePosition {
    case inside
    case outside
}

fileprivate
struct GuideLineModifier: ViewModifier {
    
    var direction: GuideLineDirection = .height(.trailing)
    var position: GuideLinePosition = .outside
    var color: Color = Color.fabulaFore2
    var textForegroundColor: Color = Color.fabulaFore1
    var textBackgroundColor: Color = Color.fabulaBack1
    var space: CGFloat = 20
    
    let min: CGFloat = 1
    let max: CGFloat = 7
    let spacing: CGFloat = 3
    
    func body(content: Content) -> some View {
        ZStack {
            content
            GeometryReader { proxy in
                ZStack {
                    switch direction {
                    case .width(let align):
                        HStack(alignment: .center, spacing: spacing) {
                            Rectangle()
                                .frame(width: min, height: max)
                            Rectangle()
                                .frame(height: min, alignment: .center)
                            getText(proxy.size.width)
                            Rectangle()
                                .frame(height: min, alignment: .center)
                            Rectangle()
                                .frame(width: min, height: max)
                        }
                        .frame(height: space)
                        .offset(x: 0, y: getYWidth(proxy, align: align))
                    case .height(let align):
                        VStack(alignment: .center, spacing: spacing) {
                            Rectangle()
                                .frame(width: max, height: min)
                            Rectangle()
                                .frame(width: min, alignment: .center)
                            getText(proxy.size.height)
                            Rectangle()
                                .frame(width: min, alignment: .center)
                            Rectangle()
                                .frame(width: max, height: min)
                        }
                        .frame(width: space)
                        .offset(x: getXHeight(proxy, align: align), y: 0)
                    }
                }
                .foregroundColor(color)
            }
        }
    }
    
    private func getText(_ value: CGFloat) -> some View {
        Text(String(format: "%.1f", value))
            .font(.caption)
            .foregroundColor(textForegroundColor)
            .fixedSize()
            .padding(.horizontal, 4)
            .background(textBackgroundColor)
            .clipShape(Capsule())
    }
    
    private func getYWidth(_ proxy: GeometryProxy, align: VerticalAlignment) -> CGFloat {
        if align == .bottom {
            return position == .outside ? proxy.size.height : proxy.size.height - space
        }else {
            return position == .outside ? -space : 0
        }
    }
    
    private func getXHeight(_ proxy: GeometryProxy, align: HorizontalAlignment) -> CGFloat {
        if align == .trailing {
            return position == .outside ? proxy.size.width : proxy.size.width - space
        }else {
            return position == .outside ? -space : 0
        }
    }
}

fileprivate
struct PyramidLeftShape: Shape {
    func path(in rect: CGRect) -> Path {
        let bottomCenter = CGPoint(x: rect.width / 2, y: rect.height - rect.width / 3.5)
        
        var path = Path()
        let startPoint = CGPoint(x: bottomCenter.x, y: 0)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: bottomCenter)
        path.addLine(to: startPoint)
        path.closeSubpath()
        return path
    }
}

fileprivate
struct PyramidRightShape: Shape {
    func path(in rect: CGRect) -> Path {
        let bottomCenter = CGPoint(x: rect.width / 2, y: rect.height - rect.width / 3.5)
        
        var path = Path()
        let startPoint = CGPoint(x: bottomCenter.x, y: 0)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: bottomCenter)
        path.addLine(to: startPoint)
        path.closeSubpath()
        return path
    }
}

fileprivate
struct PyramidBottomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let bottomCenter = CGPoint(x: rect.width / 2, y: rect.height - rect.width / 3.5)
        
        var path = Path()
        let startPoint = bottomCenter
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: startPoint)
        path.closeSubpath()
        return path
    }
}

fileprivate
struct PyramidShadowShape: Shape {
    func path(in rect: CGRect) -> Path {
        let shadowOffsetX: CGFloat = 100
        
        var path = Path()
        let startPoint = CGPoint(x: rect.width / 2, y: 0)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.width / 2 + shadowOffsetX * CGFloat.pi, y: shadowOffsetX * CGFloat.pi))
        path.addLine(to: CGPoint(x: shadowOffsetX * CGFloat.pi, y: rect.height + shadowOffsetX * CGFloat.pi))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.move(to: startPoint)
        path.closeSubpath()
        return path
    }
}

fileprivate
struct PyramidView: View {
    var color = Color.red
    var body: some View {
        ZStack{
            PyramidShadowShape()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.black.opacity(0.0)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            PyramidLeftShape()
                .fill(color)
            ZStack {
                PyramidRightShape()
                    .fill(color)
                PyramidRightShape()
                    .fill(Color.black.opacity(0.3))
            }
            ZStack {
                PyramidBottomShape()
                    .fill(color)
                PyramidBottomShape()
                    .fill(Color.black.opacity(0.4))
            }
        }
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        P17_Pyramid()
    }
}
