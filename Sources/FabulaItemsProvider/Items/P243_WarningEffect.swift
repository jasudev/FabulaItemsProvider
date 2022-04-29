//
//  P243_WarningEffect.swift
//  
//
//  Created by jasu on 2022/04/29.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P243_WarningEffect: View {
    
    @State private var interval: CGFloat = 0
    
    public init() {}
    public var body: some View {
        VStack {
            Text("Shaking")
                .font(.title)
                .warning(interval)
            Divider().frame(width: 44)
            Button {
                withAnimation(.easeInOut) {
                    self.interval += 1
                }
            } label: {
                Text("Run")
            }
        }
    }
}

struct P243_WarningEffect_Previews: PreviewProvider {
    static var previews: some View {
        P243_WarningEffect()
    }
}

fileprivate
extension View {
    func warning(_ interval: CGFloat) -> some View {
        self.modifier(WarningEffect(interval))
            .animation(Animation.default, value: interval)
    }
}

fileprivate
struct WarningEffect: GeometryEffect {
    
    var animatableData: CGFloat
    var amount: CGFloat = 3
    var shakeCount = 6

    init(_ interval: CGFloat) {
        self.animatableData = interval
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * CGFloat(shakeCount) * .pi), y: 0))
    }
}

