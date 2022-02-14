//
//  P227_Bubble.swift
//  
//
//  Created by jasu on 2022/02/13.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import LottieUI

public struct P227_Bubble: View {
    
    let state1 = LUStateData(type: .loadedFrom(URL(string: "https://assets5.lottiefiles.com/packages/lf20_rjgikbck.json")!), speed: 0.9, loopMode: .autoReverse)
    let state2 = LUStateData(type: .loadedFrom(URL(string: "https://assets10.lottiefiles.com/packages/lf20_wdqlqkhq.json")!), speed: 1.1, loopMode: .loop)
    let state3 = LUStateData(type: .loadedFrom(URL(string: "https://assets2.lottiefiles.com/packages/lf20_agu7b2gf.json")!), speed: 0.95, loopMode: .autoReverse)

    public init() {}
    public var body: some View {
        ZStack {
            ForEach(0...1, id: \.self) { index in
                LottieView(state: state1)
                    .blendMode(.screen)
                    .rotationEffect(Angle(degrees: CGFloat.random(in: -360...360)))
                    .scaleEffect(CGFloat.random(in: 0.7...1.0))
                LottieView(state: state2)
                    .blendMode(.darken)
                    .rotationEffect(Angle(degrees: CGFloat.random(in: -360...360)))
                    .scaleEffect(CGFloat.random(in: 0.7...1.0))
                LottieView(state: state3)
                    .blendMode(.screen)
                    .rotationEffect(Angle(degrees: CGFloat.random(in: -360...360)))
                    .scaleEffect(CGFloat.random(in: 0.7...1.0))
            }
        }
    }
}

struct P227_Bubble_Previews: PreviewProvider {
    static var previews: some View {
        P227_Bubble()
    }
}
