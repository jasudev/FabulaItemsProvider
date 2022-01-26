//
//  P212_SizeModifier.swift
//  
//
//  Created by jasu on 2022/01/26.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P212_SizeModifier: View {
    
    @State private var size: CGSize = .zero
    
    public init() {}
    public var body: some View {
        HStack {
            Image(systemName: "pencil.circle.fill")
                .font(.system(size: 150))
                .takeSize($size)
            Rectangle().fill(Color.fabulaPrimary)
                .frame(width: size.width, height: size.height)
        }
    }
}

fileprivate
struct SizeModifier: ViewModifier {
    
    @Binding var size: CGSize
    
    init(_ size: Binding<CGSize>) {
        _size = size
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self) { preference in
                self.size = preference
            }
    }
}

fileprivate
extension View {
    func takeSize(_ size: Binding<CGSize>) -> some View {
        self.modifier(SizeModifier(size))
    }
}

fileprivate
struct SizePreferenceKey: PreferenceKey {
    typealias V = CGSize
    static var defaultValue: V = .zero
    static func reduce(value: inout V, nextValue: () -> V) {
        value = nextValue()
    }
}

struct P212_SizeModifier_Previews: PreviewProvider {
    static var previews: some View {
        P212_SizeModifier()
    }
}
