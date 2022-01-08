//
//  P25_CurveLine.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P25_CurveLine: View {
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            CurveLineControlView(canvasSize: proxy.size)
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
struct CurveControlLine: Shape {
    
    var startPoint: CGPoint
    var control1: CGPoint
    var control2: CGPoint
    var endPoint: CGPoint
    
    func path(in rect: CGRect) -> Path {
        
        var p = Path()
        p.move(to: startPoint)
        p.addLine(to: control1)
        p.move(to: endPoint)
        p.addLine(to: control2)
        p.addLine(to: control1)
        
        return p
    }
}

fileprivate
struct CurveControlDragButton: View {
    let title: String
    let subTitle: String
    var body: some View {
        Circle()
            .stroke(lineWidth: 2)
            .fill(Color.fabulaFore1)
            .background(Color.fabulaBack1)
            .overlay(
                ZStack {
                    Text(title)
                        .font(.callout)
                        .foregroundColor(Color.fabulaFore1)
                    Text(subTitle)
                        .font(.caption)
                        .foregroundColor(Color.fabulaFore2)
                        .offset(x: 36, y: 36)
                }
            )
    }
}

fileprivate
struct CurveLineControlView: View {
    
#if os(iOS)
    @Environment(\.horizontalSizeClass) var sizeClass
#endif
    let size: CGFloat = 36.0
    var canvasSize: CGSize = .zero
    
    @State private var startPointNew: CGPoint = .zero
    @State private var startPointCurrent: CGPoint = .zero
    
    @State private var control1New: CGPoint = .zero
    @State private var control1Current: CGPoint = .zero
    
    @State private var control2New: CGPoint = .zero
    @State private var control2Current: CGPoint = .zero
    
    @State private var endPointNew: CGPoint = .zero
    @State private var endPointCurrent: CGPoint = .zero
    
    @State private var phase: CGFloat = 0
    
    var startDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.startPointCurrent = CGPoint(x: value.translation.width + self.startPointNew.x,
                                                 y: value.translation.height + self.startPointNew.y)
            }
            .onEnded { value in
                self.startPointCurrent = CGPoint(x: value.translation.width + self.startPointNew.x,
                                                 y: value.translation.height + self.startPointNew.y)
                print(self.startPointNew.x)
                self.startPointNew = self.startPointCurrent
            }
    }
    
    var endDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.endPointCurrent = CGPoint(x: value.translation.width + self.endPointNew.x,
                                               y: value.translation.height + self.endPointNew.y)
            }
            .onEnded { value in
                self.endPointCurrent = CGPoint(x: value.translation.width + self.endPointNew.x,
                                               y: value.translation.height + self.endPointNew.y)
                print(self.endPointNew.x)
                self.endPointNew = self.endPointCurrent
            }
    }
    
    var control1Drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.control1Current = CGPoint(x: value.translation.width + self.control1New.x,
                                               y: value.translation.height + self.control1New.y)
            }
            .onEnded { value in
                self.control1Current = CGPoint(x: value.translation.width + self.control1New.x,
                                               y: value.translation.height + self.control1New.y)
                print(self.control1New.x)
                self.control1New = self.control1Current
            }
    }
    
    var control2Drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.control2Current = CGPoint(x: value.translation.width + self.control2New.x,
                                               y: value.translation.height + self.control2New.y)
            }
            .onEnded { value in
                self.control2Current = CGPoint(x: value.translation.width + self.control2New.x,
                                               y: value.translation.height + self.control2New.y)
                print(self.control2New.x)
                self.control2New = self.control2Current
            }
    }
    
    var body: some View {
        ZStack {
            Color.clear
            CurveLine(startPoint: startPointCurrent,
                      control1: control1Current,
                      control2: control2Current,
                      endPoint: endPointCurrent)
                .stroke(lineWidth: 2)
                .fill(Color.fabulaPrimary)
            
            CurveControlLine(startPoint: startPointCurrent,
                             control1: control1Current,
                             control2: control2Current,
                             endPoint: endPointCurrent)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [4], dashPhase: phase))
                .fill(Color.fabulaFore1.opacity(0.5))
            
            GeometryReader { proxy in
                CurveControlDragButton(title: "S", subTitle: getPointInfo(self.startPointCurrent))
                    .frame(width: size, height: size)
                    .offset(x: self.startPointCurrent.x - size / 2, y: self.startPointCurrent.y - size / 2)
                    .gesture(startDrag)
                CurveControlDragButton(title: "E", subTitle: getPointInfo(self.endPointCurrent))
                    .frame(width: size, height: size)
                    .offset(x: self.endPointCurrent.x - size / 2, y: self.endPointCurrent.y - size / 2)
                    .gesture(endDrag)
                CurveControlDragButton(title: "C1", subTitle: getPointInfo(self.control1Current))
                    .frame(width: size, height: size)
                    .offset(x: self.control1Current.x - size / 2, y: self.control1Current.y - size / 2)
                    .gesture(control1Drag)
                CurveControlDragButton(title: "C2", subTitle: getPointInfo(self.control2Current))
                    .frame(width: size, height: size)
                    .offset(x: self.control2Current.x - size / 2, y: self.control2Current.y - size / 2)
                    .gesture(control2Drag)
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                initPosition()
            }
        }
    }
    
    private func initPosition() {
        
        var start = CGPoint(x: canvasSize.width * 0.2, y: canvasSize.height / 1.5)
        var control1 = CGPoint(x: canvasSize.width * 0.45, y: canvasSize.height * 0.3)
        var control2 = CGPoint(x: canvasSize.width * 0.55, y: canvasSize.height * 0.7)
        var end = CGPoint(x: canvasSize.width * 0.8, y: canvasSize.height / 2)
        
#if os(iOS)
        if sizeClass == .compact {
            start = CGPoint(x: canvasSize.width / 1.5, y: canvasSize.height * 0.1)
            control1 = CGPoint(x: canvasSize.width * 0.8, y: canvasSize.height * 0.3)
            control2 = CGPoint(x: canvasSize.width * 0.2, y: canvasSize.height * 0.6)
            end = CGPoint(x: canvasSize.width / 2, y: canvasSize.height * 0.8)
        }
#endif
        
        startPointNew = start
        startPointCurrent = start
        
        control1New = control1
        control1Current = control1
        
        control2New = control2
        control2Current = control2
        
        endPointNew = end
        endPointCurrent = end
    }
    
    private func getPointInfo(_ point: CGPoint) -> String {
        String(format: "X:%1.f Y:%1.f", point.x, point.y)
    }
}

struct P25_CurveLine_Previews: PreviewProvider {
    static var previews: some View {
        P25_CurveLine()
    }
}
