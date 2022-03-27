//
//  P12_Timeface.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

public struct P12_Timeface: View {
    
    @State private var isOpen: Bool = false
    @StateObject var store = TimeIntervalStore(interval: 0.1)
    
    public init() {}
    public var body: some View {
        ZStack {
            CircleTimeface(store: store)
                .shadow(radius: 6)
                .padding()
                .modifier(Drag3DModifier())
            
            FabulaSheet(isOpen: $isOpen) {
                Text("Interval").modifier(FabulaSectionModifier())
                FabulaSlider(value: $store.interval, title: "", min: 0.1, max: 0.5)
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
struct CircleDotView: View {
    var body: some View {
        GeometryReader { proxy in
            ForEach(1..<getCount(proxy), id: \.self) { tick in
                ZStack {
                    Color.clear
                    Circle()
                        .stroke(lineWidth: 1)
                        .frame(width: getFrameSize(proxy, tick), height: getFrameSize(proxy, tick))
                }
            }
        }
        .rotationEffect(Angle(degrees: -90))
    }
    
    private func getCount(_ proxy: GeometryProxy) -> Int {
        return Int(proxy.minSize / 10)
    }
    
    private func getFrameSize(_ proxy: GeometryProxy, _ tick: Int) -> CGFloat {
        var value = proxy.minSize - CGFloat(tick) * 10
        if value <= 10 {
            value = 10
        }
        return value
    }
    
}

fileprivate
struct ArcMaskShape: Shape {
    
    var angle: CGFloat = 45
    
    var animatableData: CGFloat {
        get { angle }
        set { angle = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        // 정사각형으로 만들기
        let square: CGRect
        if rect.maxX - rect.minX > rect.maxY - rect.minY { // 가로가 더 길 경우
            square = CGRect(x: rect.midX - (rect.maxY / 2.0),
                            y: rect.minY,
                            width: rect.maxY,
                            height: rect.maxY)
            
        } else { // 세로가 더 길 경우
            square = CGRect(x: rect.minX,
                            y: rect.midY - (rect.maxX / 2.0),
                            width: rect.maxX,
                            height: rect.maxX)
        }
        
        var path = Path()
        let center = CGPoint(x: square.midX, y: square.midY)
        
        path.move(to: center)
        
        path.addArc(center: center,
                    radius: square.midX - square.minX,
                    startAngle: .degrees(0),
                    endAngle: .degrees(angle),
                    clockwise: false)
        
        return path.rotation(.init(degrees: -90)).path(in: rect)
    }
}

fileprivate
struct ArcMaskShape2: Shape {
    
    var angle: CGFloat = 45
    
    var animatableData: CGFloat {
        get { angle }
        set { angle = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        // 정사각형으로 만들기
        let square: CGRect
        if rect.maxX - rect.minX > rect.maxY - rect.minY { // 가로가 더 길 경우
            square = CGRect(x: rect.midX - (rect.maxY / 2.0),
                            y: rect.minY,
                            width: rect.maxY,
                            height: rect.maxY)
            
        } else { // 세로가 더 길 경우
            square = CGRect(x: rect.minX,
                            y: rect.midY - (rect.maxX / 2.0),
                            width: rect.maxX,
                            height: rect.maxX)
        }
        
        var path = Path()
        let center = CGPoint(x: square.midX, y: square.midY)
        
        path.move(to: center)
        
        path.addArc(center: center,
                    radius: square.midX - square.minX,
                    startAngle: .degrees(angle),
                    endAngle: .degrees(360),
                    clockwise: false)
        
        return path.rotation(.init(degrees: -90)).path(in: rect)
    }
}

fileprivate
struct ClockHandView: View {
    
    @Binding var sec: Double
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                Group {
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 3, height: proxy.minSize / 2)
                        .offset(y: -(proxy.minSize / 4 - 3))
                        .rotationEffect(.degrees(sec / 60 * 360))
                    
                    Circle()
                        .fill(Color.black)
                        .frame(width: 14, height: 14)
                }
            }
        }
        .shadow(radius: 3)
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
struct Drag3DModifier: ViewModifier {
    
    @State var dragAmount = CGSize.zero
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation(.easeOut(duration: 0.12)) {
                    dragAmount = value.translation
                }
            }
            .onEnded { _ in
                withAnimation(.customSpring) {
                    dragAmount = .zero
                }
            }
    }
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(-Double(dragAmount.width) / 8), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(.degrees(Double(dragAmount.height / 8)), axis: (x: 1, y: 0, z: 0))
            .offset(dragAmount)
            .gesture(drag)
    }
}

extension P12_Timeface {
    
    struct CircleTimeface : View {
        
        @ObservedObject var store: TimeIntervalStore
        
        var body: some View {
            GeometryReader { proxy in
                ZStack {
                    store.prevImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.minSize, height: proxy.minSize)
                        .opacity(0.5)
                        .background(store.prevColor)
                        .mask(
                            CircleDotView()
                                .mask(
                                    ArcMaskShape2(angle: store.circleTime / 60 * 360)
                                )
                        )
                    
                    store.nextImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.minSize, height: proxy.minSize)
                        .opacity(0.5)
                        .background(store.nextColor)
                        .mask(
                            CircleDotView()
                                .mask(
                                    ArcMaskShape(angle: store.circleTime / 60 * 360)
                                )
                        )
                    ClockHandView(sec: $store.time)
                    
                    Circle()
                        .strokeBorder(lineWidth: 3)
                        .foregroundColor(Color.black)
                }
                
                .onAppear() {
                    DispatchQueue.main.async {
                        store.start()
                    }
                }
            }
        }
    }
    
    class TimeIntervalStore: ObservableObject {
        
        @Published var isStart: Bool = false
        @Published var time: Double = 0
        @Published var circleTime: Double = 0
        @Published var prevImage: Image = Image(systemName: "network")
        @Published var nextImage: Image = Image(systemName: "globe.asia.australia.fill")
        
        @Published var prevColor: Color = Color(hex: 0x000000)
        @Published var nextColor: Color = Color(hex: 0x5586A2)
        @Published var interval: Double = 0.1
        
        private var currentImageIndex: Int = 0
        private var images = ["globe.asia.australia.fill", "globe.americas", "network"]
        private var colors = [Color(hex: 0x5586A2), Color(hex: 0xF6D256), Color(hex: 0x0C4C89), Color(hex: 0xEF562D), Color(hex: 0x97D5E0)]
        
        
        private var timer: Timer?
        
        init(interval: Double = 0.1) {
            self.interval = interval
        }
        
        func start() {
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(run), userInfo: nil, repeats: true)
        }
        
        func stop() {
            time = 0
        }
        
        func pause() {
            timer?.invalidate()
        }
        
        func changeImage() {
            prevImage = Image(systemName: images[0])
            nextImage = Image(systemName: images[1])
            
            let imageName = images.remove(at: 0)
            images.append(imageName)
            
            prevColor = colors[0]
            nextColor = colors[1]
            
            let imageColor = colors.remove(at: 0)
            colors.append(imageColor)
        }
        
        @objc private func run() {
            time += interval
            circleTime += interval
            if Int(circleTime) == 60 {
                circleTime = 0
                DispatchQueue.main.async {
                    self.changeImage()
                }
            }
        }
        
        deinit {
            timer?.invalidate()
        }
    }
}

struct P12_Timeface_Previews: PreviewProvider {
    static var previews: some View {
        P12_Timeface()
    }
}
