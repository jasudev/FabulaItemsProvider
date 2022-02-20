//
//  P229_StarShape.swift
//  
//
//  Created by jasu on 2022/02/19.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSheet

public struct P229_StarShape: View {
    
    @State private var count: CGFloat = 5
    @State private var ratio: CGFloat = 1
    @State private var isPresented: Bool = true
    
    public init() {}
    public var body: some View {
        ZStack {
            VStack {
                GeometryReader { proxy in
                    let min = min(proxy.size.width, proxy.size.height)
                    ZStack {
                        Color.clear
                        Star(count: round(count), innerRatio: ratio)
                            .fill(Color.accentColor)
                            .frame(width: min, height: min)
                    }
                }
            }
            .padding()
            .animation(.easeInOut, value: count)
            .animation(.easeInOut, value: ratio)
            
            VStack {
                HStack {
                    Text("Count : ")
                    Slider(value: $count, in: 1...10)
                    Text("\(count, specifier: "%.2f")")
                }
                HStack {
                    Text("InnerRatio : ")
                    Slider(value: $ratio, in: 0...2)
                    Text("\(ratio, specifier: "%.2f")")
                }
            }
            .padding()
            .adaptiveAxisSheet(isPresented: $isPresented, bottomSize: 110)
        }
    }
}

fileprivate
struct Star: Shape {
    
    var count: CGFloat
    var innerRatio: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(count, innerRatio) }
        set {
            count = newValue.first
            innerRatio = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let pointAngle = .pi / count
        
        let innerPoint = CGPoint(x: center.x * innerRatio * 0.5, y: center.y * innerRatio * 0.5)
        let totalPoints = Int(count * 2.0)
        
        var currentAngle = CGFloat.pi * -0.5
        var currentBottom: CGFloat = 0
        
        var path = Path()
        path.move(to: CGPoint(x: center.x * cos(currentAngle),
                              y: center.y * sin(currentAngle)))
        
        let correction = count != round(count) ? 1 : 0
        for corner in 0..<totalPoints + correction  {
            var bottom: CGFloat = 0
            let sin = sin(currentAngle)
            let cos = cos(currentAngle)
            if (corner % 2) == 0 {
                bottom = center.y * sin
                path.addLine(to: CGPoint(x: center.x * cos, y: bottom))
            } else {
                bottom = innerPoint.y * sin
                path.addLine(to: CGPoint(x: innerPoint.x * cos, y: bottom))
            }
            currentBottom = max(bottom, currentBottom)
            currentAngle += pointAngle
        }
        
        let transform = CGAffineTransform(translationX: center.x, y: center.y + ((rect.height * 0.5 - currentBottom) * 0.5))
        return path.applying(transform)
    }
}

struct P229_StarShape_Previews: PreviewProvider {
    static var previews: some View {
        P229_StarShape()
    }
}
