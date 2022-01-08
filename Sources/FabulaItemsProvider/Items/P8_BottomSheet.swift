//
//  P8_BottomSheet.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P8_BottomSheet: View {
    
    @State private var isOpen: Bool = false
    
    @State private var minArea: Double = 38
    @State private var maxArea: Double = 300
    @State private var radius: Double = 16
    
    @State private var backgroundDisabled: Bool = true
    @State private var backgroundColor: Color = Color.black.opacity(0.16)
    
    @State private var contentCoverColor: Color = Color.fabulaBack0
    @State private var contentBGColor: Color = Color.fabulaBar2
    
    @State private var indicatorMin: Double = 4
    @State private var indicatorMax: Double = 34
    @State private var indicatorColor: Color = Color.fabulaPrimary
    @State private var indicatorBGColor: Color = Color.fabulaBar1
    
    private var constants: SheetConstants {
        SheetConstants(
            minArea: minArea,
            maxArea: maxArea,
            radius: radius,
            
            backgroundDisabled: backgroundDisabled,
            backgroundColor: backgroundColor,
            
            contentCoverColor: contentCoverColor,
            contentBGColor: contentBGColor,
            
            indicatorMin: indicatorMin,
            indicatorMax: indicatorMax,
            indicatorColor: indicatorColor,
            indicatorBGColor: indicatorBGColor
        )
    }
    
    public init() {}
    public var body: some View {
        ZStack {
            Form {
                Section(header: Text("Standard")) {
                    FabulaSlider(value: $minArea, title: "minArea", min: 24, max: 60)
                    FabulaSlider(value: $maxArea, title: "maxArea", min: 200, max: 500)
                    FabulaSlider(value: $radius, title: "radius", min: 0, max: minArea / 2)
                }
                
                Section(header: Text("Background")) {
                    FabulaToggle("backgroundDisabled", isOn: $backgroundDisabled)
                    FabulaColorPicker("backgroundColor", selection: $backgroundColor)
                }
                
                Section(header: Text("Content")) {
                    FabulaColorPicker("contentBGColor", selection: $contentBGColor)
                    FabulaColorPicker("contentCoverColor", selection: $contentCoverColor)
                }
                
                Section(header: Text("Indicator")) {
                    FabulaSlider(value: $indicatorMin, title: "indicatorMin", min: 0, max: 10)
                    FabulaSlider(value: $indicatorMax, title: "indicatorMax", min: 0, max: 80)
                    FabulaColorPicker("indicatorColor", selection: $indicatorColor)
                    FabulaColorPicker("indicatorBGColor", selection: $indicatorBGColor)
                }
            }
#if os(macOS)
            .background(Color.fabulaBackWB100.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
#endif
            .frame(maxWidth: 500)
            .padding(.bottom, minArea)
            
            GeometryReader { proxy in
                BottomSheet(isOpen: $isOpen, constants: constants) {
                    DummyView(direction: .horizontal)
                }
            }
        }
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
struct FabulaToggleStyle: ToggleStyle {
    
    @GestureState private var translation: CGFloat = 0
    @Environment(\.colorScheme) private var colorScheme
    
    static let minWidth: CGFloat = 52
    static let minHeight: CGFloat = 32
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Capsule()
                .fill(configuration.isOn ? Color.fabulaPrimary : Color.fabulaBackWB100.opacity(0.5))
            ZStack {
                GeometryReader { proxy in
                    Color.clear
                    Capsule()
                        .stroke(Color.black.opacity(0.1), lineWidth: proxy.size.height * 0.1)
                        .padding(-((proxy.size.height * 0.1) / 2))
                        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.4 : 0.2), radius: proxy.size.height * 0.03, x: (proxy.size.height * 0.03) / 2, y: (proxy.size.height * 0.03) / 2)
                }
            }
            .mask(
                Capsule()
            )
            
            Rectangle()
                .fill(Color.clear)
                .overlay(
                    GeometryReader { proxy in
                        ZStack{
                            Circle().fill(Color.fabulaBack1)
                                .frame(width: getThumbSize(proxy))
                                .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.4 : 0.2), radius: proxy.size.height * 0.05)
                                .overlay(
                                    ZStack {
                                        Image(systemName: "poweron")
                                            .font(.custom("Helvetica Bold", size: proxy.size.height * 0.36))
                                            .foregroundColor(Color.fabulaPrimary)
                                            .opacity(configuration.isOn ? 1 : 0)
                                            .scaleEffect(configuration.isOn ? 1 : 0.2)
                                        Image(systemName: "poweroff")
                                            .font(.custom("Helvetica Bold", size: proxy.size.height * 0.36))
                                            .foregroundColor(Color.fabulaFore1.opacity(0.8))
                                            .opacity(configuration.isOn ? 0 : 1)
                                            .scaleEffect(configuration.isOn ? 0.2 : 1)
                                    }
                                )
                                .rotation3DEffect(Angle(degrees: configuration.isOn ? 0 : -270), axis: (x: 0, y: 0, z:1))
                        }
                        .offset(x: configuration.isOn ? proxy.frame(in: .local).maxX - (getThumbSize(proxy) * 1.06) : proxy.frame(in: .local).minX + (proxy.size.height - getThumbSize(proxy) * 1.06))
                    }
                        .highPriorityGesture( // 하위 onTapGesture 제스처보다 우선순위를 높이기 위해 highPriorityGesture 사용
                            DragGesture().updating(self.$translation) { value, state, _ in
                                state = value.translation.width
                            }
                                .onChanged{ value in
                                    withAnimation(.customSpring) {
                                        configuration.isOn = value.translation.width > 0
                                    }
                                }
                                .onEnded{ value in
                                    
                                }
                                            )
                )
                .clipShape(Capsule())
        }
        .onTapGesture(count: 1) {
            withAnimation(Animation.customSpring) {
                configuration.isOn.toggle()
            }
        }
        .frame(minWidth: FabulaToggleStyle.minWidth, minHeight: FabulaToggleStyle.minHeight)
        
    }
    
    private func getThumbSize(_ proxy: GeometryProxy) -> CGFloat {
        proxy.size.height - proxy.size.height * 0.1
    }
}

fileprivate
struct FabulaToggle: View {
    
    private let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
#if os(macOS)
            Toggle(title, isOn: $isOn)
#else
            Text(title)
            Spacer()
            Toggle(title, isOn: $isOn)
                .frame(width: 52, height: 32)
                .toggleStyle(FabulaToggleStyle())
#endif
            
        }
    }
    
    init(_ title: String, isOn: Binding<Bool>) {
        self.title = title
        _isOn = isOn
    }
}

fileprivate
struct FabulaColorPicker: View {
    
    private let title: String
    @Binding var selection: Color
    
    var body: some View {
        HStack(spacing: 0) {
            ColorPicker(title, selection: $selection)
        }
    }
    
    init(_ title: String, selection: Binding<Color>) {
        self.title = title
        _selection = selection
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
struct DummyHRowView: View {
    var title: String
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.fabulaBack2)
            VStack(alignment: .leading) {
                HStack {
                    Label {
                        Text("Title String")
                    } icon: {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.fabulaFore2)
                    }
                }
                Text("It is not uncommon for a website or digital product to launch and miss the mark.")
                    .font(.callout)
                    .foregroundColor(Color.fabulaFore2)
                Divider()
                Text("It is not uncommon for a website or digital product to launch and miss the mark. It is not uncommon for a website or digital product to launch and miss the mark. It is not uncommon for a website or digital product to launch and miss the mark. It is not uncommon for a website or digital product to launch and miss the mark. It is not uncommon for a website or digital product to launch and miss the mark. It is not uncommon for a website or digital product to launch and miss the mark.")
                    .font(.callout)
                    .foregroundColor(Color.fabulaFore2)
                Spacer()
            }
        }
    }
}

fileprivate
struct DummyVRowView: View {
    var title: String
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.fabulaBack2)
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text(title)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color.fabulaFore1)
                }
                
                HStack {
                    Label {
                        Text("Title String")
                    } icon: {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.fabulaFore2)
                    }
                }
                Text("It is not uncommon for a website or digital product to launch and miss the mark.")
                    .font(.callout)
                    .foregroundColor(Color.fabulaFore2)
                Text("It is not uncommon for a website or digital product to launch and miss the mark. It is not uncommon for a website or digital product to launch and miss the mark. It is not uncommon for a website or digital product to launch and miss the mark. It is not uncommon for a website or digital product to launch and miss the mark. It is not uncommon for a website or digital product to launch and miss the mark. It is not uncommon for a website or digital product to launch and miss the mark.")
                    .font(.callout)
                    .foregroundColor(Color.fabulaFore2)
                Spacer()
            }
        }
    }
}

fileprivate
struct DummyView: View {
    var direction: Edge.Set = .horizontal
    var body: some View {
        ZStack {
            if direction == .horizontal {
                HStack(alignment: .top, spacing: 12) {
                    DummyVRowView(title: "It is not uncommon achieved")
                    VStack {
                        DummyHRowView(title: "and prototyping processes")
                    }
                }
            }else if direction == .vertical {
                VStack(alignment: .leading, spacing: 12) {
                    DummyVRowView(title: "It is not uncommon achieved")
                    VStack {
                        DummyHRowView(title: "and prototyping processes")
                    }
                }
            }
        }
        .padding()
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

struct P8_BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        P8_BottomSheet().preferredColorScheme(.dark)
    }
}
