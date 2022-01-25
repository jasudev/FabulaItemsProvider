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
                    self.makeView(proxy)
                }
            )
    }
    
    func makeView(_ proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }
        return Rectangle().fill(Color.clear)
    }
}

fileprivate
extension View {
    func takeFrame(_ rect: Binding<CGRect>) -> some View {
        self.modifier(FrameModifier(rect))
    }
}


struct P211_FrameModifier_Previews: PreviewProvider {
    static var previews: some View {
        P211_FrameModifier()
    }
}
