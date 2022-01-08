//
//  P165_AnimatablePair.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P165_AnimatablePair: View {
    
    @State private var trimmedTo1: CGFloat = 1.0
    @State private var trimmedTo2: CGFloat = 2.0
    @State private var isHidden: Bool = false
    
    public init() {}
    public var body: some View {
        VStack {
            GeometryReader { proxy in
                let min = min(proxy.size.width, proxy.size.height)
                ZStack {
                    Color.clear
                    MyCircle(trimmedTo1: trimmedTo1, trimmedTo2: trimmedTo2)
                        .fill(Color.fabulaPrimary)
                        .padding()
                        .animation(.easeInOut(duration: 3), value: trimmedTo1)
                        .animation(.easeInOut(duration: 6), value: trimmedTo2)
                        .frame(width: min, height: min)
                    MyCircle(trimmedTo1: trimmedTo1, trimmedTo2: trimmedTo2)
                        .fill(Color.fabulaPrimary)
                        .opacity(0.5)
                        .padding()
                        .animation(.easeInOut(duration: 3), value: trimmedTo1)
                        .animation(.easeInOut(duration: 6), value: trimmedTo2)
                        .frame(width: min / 2, height: min / 2)
                        .rotationEffect(Angle(degrees: 90))
                }
            }
            
            Button {
                trimmedTo1 = isHidden ? 1.0 : 0.0
                trimmedTo2 = isHidden ? 2.0 : 0.0
                isHidden.toggle()
            } label: {
                Text("Animate!")
                    .padding()
                    .background(Color.fabulaPrimary)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
        }
        .padding()
    }
}

fileprivate
extension P165_AnimatablePair{
    struct MyCircle: Shape {
        
        var trimmedTo1: CGFloat
        var trimmedTo2: CGFloat
        
        var animatableData: AnimatablePair<CGFloat, CGFloat> {
            get { AnimatablePair(trimmedTo1, trimmedTo2) }
            set {
                trimmedTo1 = newValue.first
                trimmedTo2 = newValue.second
            }
        }
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = rect.width / 2
            let start = Angle(radians: .pi * trimmedTo1 * 2)
            let end = Angle(radians: .pi * trimmedTo2 * 3)
            
            path.addArc(center: center, radius: radius, startAngle: start, endAngle: end, clockwise: false)
            return path
                .trimmedPath(from: 0.0, to: trimmedTo1)
                .trimmedPath(from: trimmedTo1, to: trimmedTo2)
                .strokedPath(.init(lineWidth: 6, lineCap: .round))
        }
    }
}

struct P165_AnimatablePair_Previews: PreviewProvider {
    static var previews: some View {
        P165_AnimatablePair()
    }
}
