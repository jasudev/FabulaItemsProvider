//
//  P181_ScrollOffset.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P181_ScrollOffset: View {
    
    @State private var offset: CGPoint = .zero
    
    public init() {}
    public var body: some View {
        VStack {
            Text("Scroll Position Y: \(offset.y)")
            ScrollView {
                ZStack {
                    LazyVStack {
                        ForEach(0...1000, id: \.self) { index in
                            Text("\(index)")
                                .fontWeight(.semibold)
                                .font(.headline)
                        }
                    }
                    OffsetInScrollView(named: "scroll")
                }
            }
            .modifier(OffsetOutScrollModifier(offset: $offset, named: "scroll"))
        }
        .padding()
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

struct P181_ScrollOffset_Previews: PreviewProvider {
    static var previews: some View {
        P181_ScrollOffset()
    }
}
