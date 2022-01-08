//
//  P198_PolygonShape.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P198_PolygonShape: View {
    @State private var sideCount: Double = 3
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            PolygonShape(sideCount: Double(Int(sideCount)))
                .fill(Color.fabulaPrimary)
                .overlay(
                    PolygonShape(sideCount: Double(Int(sideCount)))
                        .stroke(Color.fabulaPrimary, lineWidth: 2)
                )
                .rotationEffect(Angle(degrees: 180))
            Divider().frame(width: 44)
            Slider(value: $sideCount, in: 1...15)
            Spacer()
        }
        .animation(.easeInOut(duration: 0.5), value: sideCount)
        .padding()
    }
}

fileprivate
struct PolygonShape: Shape {
    
    var sideCount: Double
    
    var animatableData: Double {
        get { return sideCount }
        set { sideCount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {

        let size = Double(min(rect.size.width, rect.size.height) / 2.0)
        let center = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        var path = Path()
        let correction = sideCount != round(sideCount) ? 1 : 0
        for i in 0..<Int(sideCount) + correction {
            let angle = (Double.pi / 180 * (360.0 / sideCount) * Double(i))
            let vertex = CGPoint(x: center.x + Double(sin(angle) * size),
                             y: center.y + Double(cos(angle) * size))

            if i == 0 {
                path.move(to: vertex)
            } else {
                path.addLine(to: vertex)
            }
        }
        
        path.closeSubpath()
        return path
    }
}

struct P198_PolygonShape_Previews: PreviewProvider {
    static var previews: some View {
        P198_PolygonShape()
    }
}
