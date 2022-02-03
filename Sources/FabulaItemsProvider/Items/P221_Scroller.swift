//
//  P221_Scroller.swift
//  
//
//  Created by jasu on 2022/02/03.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import Scroller

public struct P221_Scroller: View {
    
    @State private var selection: Int = 0
    @State private var valueH: CGFloat = 0
    @State private var valueV: CGFloat = 0
    
    public init() {}
    public var body: some View {
        TabView(selection: $selection) {
            VStack(alignment: .leading, spacing: 8) {
                Text("●").foregroundColor(Color.orange) +
                Text(" Vertical Total Value: \(valueV)")
                    .font(.callout)
                    .bold()
                Scroller(.vertical, value: $valueV) {
                    ForEach(0...5, id: \.self) { index in
                        GeometryReader { proxy in
                            ScrollerVContent(value: proxy.scrollerValue(.vertical))
                        }
                    }
                } lastContent: {
                    Rectangle()
                        .fill(Color.blue)
                        .overlay(Text("LastView"))
                        .foregroundColor(Color.white)
                }
            }
            .padding()
            .tabItem {
                Image(systemName: "square.split.1x2")
                Text("Vertical")
            }
            .tag(0)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("●").foregroundColor(Color.purple) +
                Text(" Horizontal Total Value: \(valueH)")
                    .font(.callout)
                    .bold()
                Scroller(.horizontal, value: $valueH) {
                    ForEach(0...5, id: \.self) { index in
                        GeometryReader { proxy in
                            ScrollerHContent(value: proxy.scrollerValue(.horizontal))
                        }
                    }
                } lastContent: {
                    Rectangle()
                        .fill(Color.red)
                        .overlay(Text("LastView"))
                        .foregroundColor(Color.white)
                }
            }
            .padding()
            .tabItem {
                Image(systemName: "square.split.2x1")
                Text("Horizontal")
            }
            .tag(1)
        }
#if os(macOS)
        .padding()
#endif
    }
}

fileprivate
struct ScrollerHContent: ScrollerContent {
    var value: CGFloat = 0
    var body: some View {
        GeometryReader { proxy in
            InfoView(axes: .horizontal, value: value, proxy: proxy)
                .offset(x: proxy.size.width * value)
                .padding(10)
            Rectangle().fill(Color.red)
                .frame(width: 5, height: proxy.size.height * value)
                .offset(x: proxy.size.width * value)
            
        }
        .background(Color.purple.opacity(1.0 - value))
    }
}

fileprivate
struct ScrollerVContent: ScrollerContent {
    var value: CGFloat = 0
    var body: some View {
        GeometryReader { proxy in
            InfoView(axes: .vertical, value: value, proxy: proxy)
                .offset(y: proxy.size.height * value)
                .padding(10)
            Rectangle().fill(Color.blue)
                .frame(width: proxy.size.width * value, height: 5)
                .offset(y: proxy.size.height * value)
        }
        .background(Color.orange.opacity(1.0 - value))
    }
}

fileprivate
struct InfoView : View {
    
    let axes: Axis.Set
    let value: CGFloat
    let proxy: GeometryProxy
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("size : \(proxy.size.debugDescription)")
            Text("value: \(value)")
            if axes == .vertical {
                Text("position Y: \(proxy.size.height * value)")
            }else {
                Text("position X: \(proxy.size.width * value)")
            }
        }
        .font(.callout)
        .foregroundColor(Color.white)
    }
}

struct P221_Scroller_Previews: PreviewProvider {
    static var previews: some View {
        P221_Scroller()
    }
}
