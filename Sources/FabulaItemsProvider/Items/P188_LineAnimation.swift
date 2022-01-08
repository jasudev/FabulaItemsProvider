//
//  P188_LineAnimation.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P188_LineAnimation: View {

    @State var startPoint: CGPoint = .zero
    @State var endPoint: CGPoint = .zero
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                Line(startPoint: startPoint, endPoint: endPoint)
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .fill(Color.fabulaPrimary)
                
                Button("Animation") {
                    withAnimation {
                        changePoints(size: proxy.size)
                    }
                }
                .padding()
                .background(Color.fabulaPrimary)
                .foregroundColor(Color.white)
                .clipShape(Capsule())
                .buttonStyle(PlainButtonStyle())
            }
            .onAppear {
                changePoints(size: proxy.size)
            }
        }
    }
    
    private func changePoints(size: CGSize) {
        startPoint = CGPoint(x: CGFloat.random(in: 0..<size.width), y: CGFloat.random(in: 0..<size.height))
        endPoint = CGPoint(x: CGFloat.random(in: 0..<size.width), y: CGFloat.random(in: 0..<size.height))
    }
}

fileprivate
struct Line: Shape {
    var startPoint: CGPoint
    var endPoint: CGPoint
    var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
        get { AnimatablePair(startPoint.animatableData, endPoint.animatableData) }
        set { (startPoint.animatableData, endPoint.animatableData) = (newValue.first, newValue.second) }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.startPoint)
            p.addLine(to: self.endPoint)
        }
    }
}

struct P188_LineAnimation_Previews: PreviewProvider {
    static var previews: some View {
        P188_LineAnimation()
    }
}
