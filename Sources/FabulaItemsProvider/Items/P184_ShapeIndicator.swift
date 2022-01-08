//
//  P184_ShapeIndicator.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P184_ShapeIndicator: View {
    
    @State private var offsetValue: ScrollOffsetValue = ScrollOffsetValue()
    
    public init() {}
    public var body: some View {
        ZStack {
            HStack {
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 8) {
                        Text("offsetValue:\nX: \(Int(offsetValue.x)), Y: \(Int(offsetValue.y))")
                        Text("contentSize:\nW: \(Int(offsetValue.contentSize.width)), H: \(Int(offsetValue.contentSize.height))")
                        Text("containerSize:\nW: \(Int(offsetValue.containerSize.width)), H: \(Int(offsetValue.containerSize.height))")
                    }
                    .font(.caption)
                    ZStack {
                        ShapeIndicator(count: 5,
                                       maxValue: offsetValue.contentSize.height,
                                       indicatorWidth: 5,
                                       indicatorColor: Color.red,
                                       containerSize: offsetValue.containerSize.height,
                                       currentValue: offsetValue.y) {
                            RoundedRectangle(cornerRadius: 50)
                        }
                        ShapeIndicator(count: 5,
                                       maxValue: offsetValue.contentSize.height,
                                       indicatorWidth: 5,
                                       indicatorColor: Color.blue,
                                       containerSize: offsetValue.containerSize.height,
                                       currentValue: offsetValue.y) {
                            Capsule()
                        }
                                       .padding(20)
                        ShapeIndicator(count: 5,
                                       maxValue: offsetValue.contentSize.height,
                                       indicatorWidth: 5,
                                       indicatorColor: Color.green,
                                       containerSize: offsetValue.containerSize.height,
                                       currentValue: offsetValue.y) {
                            Circle()
                        }
                                       .padding(40)
                    }
                    Spacer()
                }
                Divider()
                ScrollView {
                    ZStack {
                        LazyVStack {
                            ForEach(0..<60, id: \.self) { index in
                                Text("\(index)")
                                    .padding()
                            }
                        }
                        OffsetInScrollView(named: "scroll")
                    }
                }
            }
        }
        .modifier(OffsetOutScrollModifier(offsetValue: $offsetValue, named: "scroll"))
        .padding()
        .frame(maxWidth: 500)
    }
}

fileprivate
struct ScrollOffsetValue: Equatable {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var contentSize: CGSize = .zero
    var containerSize: CGSize = .zero
}

fileprivate
struct ScrollOffsetKey: PreferenceKey {
    typealias Value = ScrollOffsetValue
    static var defaultValue = ScrollOffsetValue()
    static func reduce(value: inout Value, nextValue: () -> Value) {
        let newValue = nextValue()
        value.x += newValue.x
        value.y += newValue.y
        value.contentSize = newValue.contentSize
        value.containerSize = newValue.containerSize
    }
}

fileprivate
struct OffsetInScrollView: View {
    let named: String
    var body: some View {
        GeometryReader { proxy in
            let offsetValue = ScrollOffsetValue(x: proxy.frame(in: .named(named)).minX,
                                                y: proxy.frame(in: .named(named)).minY,
                                                contentSize: proxy.size,
                                                containerSize: .zero)
            Color.clear.preference(key: ScrollOffsetKey.self, value: offsetValue)
        }
    }
}

fileprivate
struct OffsetOutScrollModifier: ViewModifier {
    
    @Binding var offsetValue: ScrollOffsetValue
    let named: String
    
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .coordinateSpace(name: named)
                .onPreferenceChange(ScrollOffsetKey.self) { value in
                    offsetValue = value
                    offsetValue.contentSize = CGSize(width: offsetValue.contentSize.width - proxy.size.width,
                                                     height: offsetValue.contentSize.height - proxy.size.height)
                    offsetValue.containerSize = proxy.size
                }
        }
    }
}

fileprivate
struct ShapeIndicator<Content>: View where Content: Shape {
    
    let count: Int
    let maxValue: CGFloat
    let indicatorWidth: CGFloat
    let indicatorColor: Color
    let containerSize: CGFloat
    var currentValue: CGFloat
    
    var content: () -> Content
    
    var body: some View {
        let size: CGFloat = maxValue / CGFloat(count)
        let delta: CGFloat = size / maxValue
        let current: CGFloat = ((-1 * currentValue) / maxValue)
        let start: CGFloat = current - delta * 0.5
        let end: CGFloat = current + delta * 0.5
        content()
            .trim(from: start, to: end)
            .stroke(indicatorColor, style: StrokeStyle(lineWidth: indicatorWidth, lineCap: .round, lineJoin: .round))
            .opacity(containerSize >= (maxValue + containerSize) ? 0 : 1)
    }
}

struct P184_ShapeIndicator_Previews: PreviewProvider {
    static var previews: some View {
        P184_ShapeIndicator()
    }
}
