//
//  P226_LottieUIScroller.swift
//  
//
//  Created by jasu on 2022/02/13.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import LottieUI
import Scroller

public struct P226_LottieUIScroller: View {
    
    let state1 = LUStateData(type: .loadedFrom(URL(string: "https://assets2.lottiefiles.com/packages/lf20_ca0xjdgv.json")!), speed: 1.0, loopMode: .loop, isControlEnabled: true)
    let state2 = LUStateData(type: .loadedFrom(URL(string: "https://assets2.lottiefiles.com/private_files/lf30_d7svjitp.json")!), speed: 1.0, loopMode: .loop, isControlEnabled: true)
    let state3 = LUStateData(type: .loadedFrom(URL(string: "https://assets1.lottiefiles.com/packages/lf20_wcjgoacf.json")!), speed: 1.0, loopMode: .loop, isControlEnabled: true)
    
    @State private var scrollerValue: CGFloat = 0
    
    public init() {}
    public var body: some View {
        Scroller(.horizontal, showsIndicators: true, value: $scrollerValue) {
            GeometryReader { proxy in
                ScrollerLottieContent(value: proxy.scrollerValue(.horizontal), state: state1)
                    .overlay(
                        Text("Horizontal Scroll →")
                            .offset(x: proxy.size.width * proxy.scrollerValue(.horizontal))
                            .opacity(1.0 - proxy.scrollerValue(.horizontal) * 16.0)
                    )
            }
            .background(Color.red.opacity(0.2))
            GeometryReader { proxy in
                ScrollerLottieContent(value: proxy.scrollerValue(.horizontal), state: state2)
            }
            .background(Color.green.opacity(0.2))
            GeometryReader { proxy in
                ScrollerLottieContent(value: proxy.scrollerValue(.horizontal), state: state3)
            }
            .background(Color.blue.opacity(0.2))
        } lastContent: {
            Text("LottieUI with Scroller.")
        }
    }
}

fileprivate
struct ScrollerLottieContent: ScrollerContent {
    
    var value: CGFloat = 0
    let state: LUStateData
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                LottieView(state: state, value: value)
                Text("Value: \(value)")
                    .font(.caption)
                    .padding()
            }
            .offset(x: proxy.size.width * 0.56 * value)
        }
    }
}

struct P226_LottieUIScroller_Previews: PreviewProvider {
    static var previews: some View {
        P226_LottieUIScroller()
    }
}
