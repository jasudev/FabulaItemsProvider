//
//  P254_GeometryEffect.swift
//  
//
//  Created by jasu on 2022/05/22.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P254_GeometryEffect: View {
    
    @State private var animateIndex: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                let newPosition1 = newPosition1(proxy.minSize / 4)
                let newPosition2 = newPosition2(proxy.minSize / 4)
                Rectangle()
                    .foregroundColor(.fabulaPrimary)
                    .frame(width: proxy.minSize / 2, height: proxy.minSize / 2)
                    .overlay(PositionView())
                    .modifier(MyEffect(positionX: newPosition1.x,
                                       positionY: newPosition1.y))
                Rectangle()
                    .foregroundColor(.fabulaSecondary)
                    .frame(width: proxy.minSize / 2, height: proxy.minSize / 2)
                    .overlay(PositionView())
                    .modifier(MyEffect(positionX: newPosition2.x,
                                       positionY: newPosition2.y))
            }
            .onReceive(timer, perform: { t in
                withAnimation(.easeInOut(duration: 1)) {
                    animateIndex += 1
                    if animateIndex >= 4 {
                        animateIndex = 0
                    }
                }
            })
        }
        .padding()
    }
    
    private func newPosition1(_ maxValue: CGFloat) -> CGPoint {
        switch animateIndex {
        case 0: return CGPoint(x: -maxValue, y: -maxValue)
        case 1: return CGPoint(x: -maxValue, y: maxValue)
        case 2: return CGPoint(x: maxValue, y: maxValue)
        case 3: return CGPoint(x: maxValue, y: -maxValue)
        default: return CGPoint.zero
        }
    }
    
    private func newPosition2(_ maxValue: CGFloat) -> CGPoint {
        switch animateIndex {
        case 0: return CGPoint(x: maxValue, y: maxValue)
        case 1: return CGPoint(x: maxValue, y: -maxValue)
        case 2: return CGPoint(x: -maxValue, y: -maxValue)
        case 3: return CGPoint(x: -maxValue, y: maxValue)
        default: return CGPoint.zero
        }
    }
}

fileprivate
struct MyEffect: GeometryEffect {
    
    var positionX: CGFloat = 0
    var positionY: CGFloat = 0
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(positionX, positionY)
        }
        set {
            positionX = newValue.first
            positionY = newValue.second
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(
            CGAffineTransform(translationX: positionX, y: positionY)
        )
    }
}

fileprivate
struct PositionView: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                VStack(alignment: .leading) {
                    Text("x = \(Int(proxy.frame(in: .global).minX))")
                    Text("y = \(Int(proxy.frame(in: .global).minY))")
                }
            }
            .foregroundColor(.white)
            .font(.title3)
        }
        .padding()
    }
}

struct P254_GeometryEffect_Previews: PreviewProvider {
    static var previews: some View {
        P254_GeometryEffect()
    }
}
