//
//  P211_FrameModifier.swift
//  
//
//  Created by jasu on 2022/01/25.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P211_FrameModifier: View {
    
    @State private var leftRect: CGRect = .zero

    public init() {}
    public var body: some View {
        HStack(spacing: 0) {
            Text("Left")
                .frame(width: 150, height: 300)
                .background(Color.purple)
                .takeFrame($leftRect)

            Text("Right")
                .frame(width: leftRect.width, height: leftRect.height)
                .background(Color.blue)
        }
    }
}

fileprivate
struct FrameModifier: ViewModifier {
    
    @Binding var rect: CGRect
    
    init(_ rect: Binding<CGRect>) {
        _rect = rect
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(key: FramePreferenceKey.self, value: proxy.frame(in: .global))
                }
            )
            .onPreferenceChange(FramePreferenceKey.self) { preference in
                self.rect = preference
            }
    }
}

fileprivate
extension View {
    func takeFrame(_ rect: Binding<CGRect>) -> some View {
        self.modifier(FrameModifier(rect))
    }
}

fileprivate
struct FramePreferenceKey: PreferenceKey {
    typealias V = CGRect
    static var defaultValue: V = .zero
    static func reduce(value: inout V, nextValue: () -> V) {
        value = nextValue()
    }
}


struct P211_FrameModifier_Previews: PreviewProvider {
    static var previews: some View {
        P211_FrameModifier()
    }
}
