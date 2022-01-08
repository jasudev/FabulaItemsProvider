//
//  P42_Angle.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//
import SwiftUI

public struct P42_Angle: View {
    
    @State private var degrees: CGFloat = 0
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                ZStack {
                    ArcShape(endDegrees: degrees)
                        .stroke(Color.fabulaPrimary, lineWidth: 10)
                        .rotationEffect(Angle(degrees: -90))
                    Rectangle()
                        .fill(Color.fabulaPrimary)
                        .rotationEffect(Angle(degrees: degrees))
                        .frame(width: 100, height: 100)
                    Text("\(Int(degrees))°")
                        .font(.title)
                        .animation(.none, value: degrees)
                }
                .frame(width: proxy.minSize * 0.8, height: proxy.minSize * 0.8)
            }
        }
        .onTapGesture {
            setAnimation(degrees == 0 ? 360.0 : 0.0)
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(.linear(duration: 5.0)) {
                    setAnimation(360)
                }
            }
        }
    }
    
    private func setAnimation(_ degrees: CGFloat) {
        withAnimation(.linear(duration: 5.0)) {
            self.degrees = degrees
        }
    }
}

fileprivate
struct ArcShape: Shape {
    
    var endDegrees: CGFloat
    
    var animatableData: CGFloat {
        get {
            endDegrees
        } set {
            endDegrees = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                     radius: rect.width / 2 ,
                     startAngle: Angle.zero,
                     endAngle: Angle(degrees: endDegrees),
                     clockwise: false)
        }
    }
}

struct P42_Angle_Previews: PreviewProvider {
    static var previews: some View {
        P42_Angle()
    }
}
