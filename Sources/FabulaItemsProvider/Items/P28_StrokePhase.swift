//
//  P28_StrokePhase.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P28_StrokePhase: View {
    
    @State private var phase: CGFloat = 0
    @State private var dash: Double = 5
    @State private var lineWidth: Double = 1
    @State private var lineColor: Color = Color.fabulaPrimary
    
    @State private var isOpen: Bool = false
    
    public init() {}
    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                ZStack {
                    Color.clear
                    if proxy.size.width < proxy.size.height {
                        HStack {
                            VStack {
                                getGroup1()
                            }
                            VStack {
                                getGroup2()
                            }
                        }
                    }else {
                        VStack {
                            HStack {
                                getGroup1()
                            }
                            HStack {
                                getGroup2()
                            }
                        }
                    }
                }
            }
            .foregroundColor(lineColor)
            FabulaSheet(isOpen: $isOpen) {
                Text("Size").modifier(FabulaSectionModifier())
                FabulaSlider(value: $lineWidth, title: "Line Width", min: 1, max: 10)
                ColorPicker("Line Color", selection: $lineColor)
            }
        }
    }
    
    private func getGroup1() -> some View {
        Group {
            Line(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 100, y: 100))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [dash], dashPhase: phase))
                .frame(width: 100, height: 100)
                .padding()
            
            CurveLine(startPoint: CGPoint(x: 0, y: 0), control1: CGPoint(x: 20, y: 80), control2: CGPoint(x: 80, y: 20), endPoint: CGPoint(x: 100, y: 100))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [dash], dashPhase: phase))
                .frame(width: 100, height: 100)
                .padding()
            
            Rectangle()
                .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [dash], dashPhase: phase))
                .frame(width: 100, height: 100)
                .padding()
            
            Circle()
                .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [dash], dashPhase: phase))
                .frame(width: 100, height: 100)
                .padding()
        }
    }
    
    private func getGroup2() -> some View {
        Group {
            Capsule()
                .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [dash], dashPhase: phase))
                .frame(width: 100, height: 70)
                .padding()
            
            Triangle()
                .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [dash], dashPhase: phase))
                .frame(width: 100, height: 100)
                .padding()
            
            Ellipse()
                .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [dash], dashPhase: phase))
                .frame(width: 100, height: 70)
                .padding()
            
            RoundedRectangle(cornerRadius: 16)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [dash], dashPhase: phase))
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}

fileprivate
struct CurveLine: Shape {
    
    var startPoint: CGPoint
    var control1: CGPoint
    var control2: CGPoint
    var endPoint: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: startPoint)
        p.addCurve(to: endPoint, control1: control1, control2: control2)
        return p
    }
}

fileprivate
struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.width / 2, y: 0))
        p.addLines([CGPoint(x: rect.width / 2, y: 0),
                    CGPoint(x: rect.width, y: rect.height),
                    CGPoint(x: 0, y: rect.height),
                    CGPoint(x: rect.width / 2, y: 0)
                   ])
        return p
    }
}

fileprivate
struct Line: Shape {
    
    var startPoint: CGPoint
    var endPoint: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: startPoint)
        p.addLine(to: endPoint)
        return p
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

struct P28_StrokePhase_Previews: PreviewProvider {
    static var previews: some View {
        P28_StrokePhase()
    }
}
