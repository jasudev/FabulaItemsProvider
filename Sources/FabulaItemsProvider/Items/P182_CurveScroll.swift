//
//  P182_CurveScroll.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

// Warning: This code must be executed in Xcode 13.2 beta version or later. Memory issues may arise when running on Xcode 13.2 beta or lower versions.
// https://developer.apple.com/forums/thread/691415

import SwiftUI

public struct P182_CurveScroll: View {
    
    let gapX: CGFloat = 80
    @State private var offset: CGPoint = .zero
    
    public init() {}
    public var body: some View {
        VStack {
            Text("Scroll Position Y: \(offset.y)")
            GeometryReader { geoProxy in
                ScrollView {
                    ZStack {
                        LazyVStack {
                            ForEach(0...1000, id: \.self) { index in
                                GeometryReader { proxy in
                                    let y = proxy.frame(in: .named("scroll")).minY
                                    ZStack {
                                        Color.clear
                                        HStack {
                                            Text("\(index)")
                                                .fontWeight(.semibold)
                                                .font(.headline)
                                        }
                                    }
                                    .offset(x: getCurveValue(y, geoProxy.size.height) * gapX - gapX)
                                }
                            }
                        }
                        OffsetInScrollView(named: "scroll")
                    }
                }
            }
            .modifier(OffsetOutScrollModifier(offset: $offset, named: "scroll"))
        }
        .padding()
    }
    
    func getCurveValue(_ current: Double, _ total: Double) -> CGFloat {
        let x = Double(current) / Double(total)
        let y = (sin(2 * .pi * x - .pi)) / 2.0
        return 1 + 2 * CGFloat(y)
    }
}

fileprivate
struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGPoint
    static var defaultValue = CGPoint.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        let nextPoint = nextValue()
        value.x += nextPoint.x
        value.y += nextPoint.y
    }
}

fileprivate
struct OffsetInScrollView: View {
    let named: String
    var body: some View {
        GeometryReader { proxy in
            let offset = CGPoint(x: proxy.frame(in: .named(named)).minX, y: proxy.frame(in: .named(named)).minY)
            Color.clear.preference(key: ScrollOffsetKey.self, value: offset)
        }
    }
}

fileprivate
struct OffsetOutScrollModifier: ViewModifier {
    
    @Binding var offset: CGPoint
    let named: String
    
    func body(content: Content) -> some View {
        content
            .coordinateSpace(name: named)
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                offset = value
            }
    }
}

struct P182_CurveScroll_Previews: PreviewProvider {
    static var previews: some View {
        P182_CurveScroll()
    }
}
