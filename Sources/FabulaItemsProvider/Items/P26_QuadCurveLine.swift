//
//  P26_QuadCurveLine.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P26_QuadCurveLine: View {
    
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
    var control: CGPoint
    var endPoint: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        p.move(to: startPoint)
        p.addQuadCurve(to: endPoint, control: control)
        
        return p
    }
}

fileprivate
struct CurveControlLine: Shape {
    
    var startPoint: CGPoint
    var control: CGPoint
    var endPoint: CGPoint
    
    func path(in rect: CGRect) -> Path {
        
        var p = Path()
        p.move(to: startPoint)
        p.addLine(to: control)
        p.addLine(to: endPoint)
        
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
    
    @State private var controlNew: CGPoint = .zero
    @State private var controlCurrent: CGPoint = .zero
    
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
    
    var controlDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.controlCurrent = CGPoint(x: value.translation.width + self.controlNew.x,
                                              y: value.translation.height + self.controlNew.y)
            }
            .onEnded { value in
                self.controlCurrent = CGPoint(x: value.translation.width + self.controlNew.x,
                                              y: value.translation.height + self.controlNew.y)
                print(self.controlNew.x)
                self.controlNew = self.controlCurrent
            }
    }
    
    var body: some View {
        ZStack {
            Color.clear
            CurveLine(startPoint: startPointCurrent,
                      control: controlCurrent,
                      endPoint: endPointCurrent)
                .stroke(lineWidth: 2)
                .fill(Color.fabulaPrimary)
            
            CurveControlLine(startPoint: startPointCurrent,
                             control: controlCurrent,
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
                CurveControlDragButton(title: "C", subTitle: getPointInfo(self.controlCurrent))
                    .frame(width: size, height: size)
                    .offset(x: self.controlCurrent.x - size / 2, y: self.controlCurrent.y - size / 2)
                    .gesture(controlDrag)
                
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
        var control = CGPoint(x: canvasSize.width * 0.3, y: canvasSize.height * 0.35)
        var end = CGPoint(x: canvasSize.width * 0.8, y: canvasSize.height / 2)
        
#if os(iOS)
        if sizeClass == .compact {
            start = CGPoint(x: canvasSize.width / 4, y: canvasSize.height * 0.1)
            control = CGPoint(x: canvasSize.width * 0.8, y: canvasSize.height * 0.3)
            end = CGPoint(x: canvasSize.width / 2, y: canvasSize.height * 0.8)
        }
#endif
        
        startPointNew = start
        startPointCurrent = start
        
        controlNew = control
        controlCurrent = control
        
        endPointNew = end
        endPointCurrent = end
    }
    
    private func getPointInfo(_ point: CGPoint) -> String {
        String(format: "X:%1.f Y:%1.f", point.x, point.y)
    }
}

struct P26_QuadCurveLine_Previews: PreviewProvider {
    static var previews: some View {
        P25_CurveLine()
    }
}
