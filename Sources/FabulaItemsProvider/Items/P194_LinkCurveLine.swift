//
//  P194_LinkCurveLine.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P194_LinkCurveLine: View {
    
    let circleSize: CGFloat = 36
    @GestureState private var leftPoint: CGPoint = .zero
    @GestureState private var rightPoint: CGPoint = .zero
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                Circle()
                    .frame(width: circleSize, height: circleSize)
                    .offset(x: leftPoint.x, y: leftPoint.y)
                    .gesture(
                        DragGesture().updating($leftPoint, body: { value, state, transition in
                            state = CGPoint(x: value.translation.width,
                                            y: value.translation.height)
                        })
                    )
                Capsule()
                    .frame(width: 20, height: circleSize * 10)
                    .offset(x: rightPoint.x + proxy.size.width - 20,
                            y: rightPoint.y - circleSize * 4)
                    .gesture(
                        DragGesture().updating($rightPoint, body: { value, state, transition in
                            state = CGPoint(x: value.translation.width,
                                            y: value.translation.height)
                        })
                    )
                
                ForEach(0..<10, id: \.self) { index in
                    VerticalCurveLine(startPoint: CGPoint(x: leftPoint.x + circleSize * 0.5,
                                                          y: leftPoint.y + circleSize * 0.5),
                                      endPoint: CGPoint(x: rightPoint.x + proxy.size.width - circleSize * 0.5,
                                                        y: rightPoint.y + circleSize * 0.5 + circleSize * CGFloat(5 - index)),
                                      lineWidth: 1)
                }
                
            }
            .foregroundColor(Color.fabulaPrimary)
            .offset(y: proxy.size.height * 0.5)
            .animation(.easeInOut, value: leftPoint)
            .animation(.easeInOut, value: rightPoint)
        }
        .padding()
        .frame(maxWidth: 500)
    }
}

fileprivate
struct VerticalCurveLine: View {
    let startPoint: CGPoint
    let endPoint: CGPoint
    let lineWidth: CGFloat
    var body: some View {
        GeometryReader { proxy in
            CurveLine(startPoint: startPoint,
                      control1: CGPoint(x: proxy.size.width * 0.6, y: startPoint.y + proxy.size.height * 0.05),
                      control2: CGPoint(x: proxy.size.width * 0.6, y: endPoint.y - proxy.size.height * 0.05),
                      endPoint: endPoint)
                .stroke(lineWidth: lineWidth)
        }
    }
    
    struct CurveLine: Shape {
        
        var startPoint: CGPoint
        var control1: CGPoint
        var control2: CGPoint
        var endPoint: CGPoint
        
        var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
            get { AnimatablePair(startPoint.animatableData, endPoint.animatableData) }
            set { (startPoint.animatableData, endPoint.animatableData) = (newValue.first, newValue.second) }
        }
        
        func path(in rect: CGRect) -> Path {
            var p = Path()
            
            p.move(to: startPoint)
            p.addCurve(to: endPoint, control1: control1, control2: control2)
            
            return p
        }
    }
}

struct P194_LinkCurveLine_Previews: PreviewProvider {
    static var previews: some View {
        P194_LinkCurveLine()
    }
}
