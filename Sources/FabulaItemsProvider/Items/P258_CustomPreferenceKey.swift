//
//  P258_CustomPreferenceKey.swift
//  
//
//  Created by jasu on 2022/05/26.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P258_CustomPreferenceKey: View {
    
    @State private var scale: CGFloat = 0.1
    @State private var size: CGFloat = 230
    @State private var isPresented: Bool = true
    
    public init() {}
    public var body: some View {
        ZStack {
            Color.clear
            RoundedRectangle(cornerRadius: 11)
                .stroke(lineWidth: 2)
                .fill(Color.fabulaPrimary)
                .frame(width: size, height: size)
                .preference(key: SubViewInfoPreferenceKey.self, value: SubViewInfo(index: 2, size: CGSize(width: size, height: size), color: Color.fabulaSecondary))
                .scaleEffect(scale - 1.0)
        }
        .overlayPreferenceValue(SubViewInfoPreferenceKey.self) { value in
            Circle()
                .stroke(lineWidth: 2)
                .fill(value.color)
                .frame(width: value.size.width, height: value.size.height)
                .scaleEffect(scale)
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 3.0).repeatForever()) {
                    scale = 1.5
                }
            }
        }
        .overlay(
            Slider(value: $size, in: 50...300)
                .padding()
                .adaptiveAxisSheet(isPresented: $isPresented)
        )
    }
}

fileprivate
struct SubViewInfo: Equatable {
    let index: Int
    let size: CGSize
    let color: Color
}

fileprivate
struct SubViewInfoPreferenceKey: PreferenceKey {
    typealias Value = SubViewInfo
    static var defaultValue: SubViewInfo = SubViewInfo(index: 0, size: .zero, color: .red)
    static func reduce(value: inout SubViewInfo, nextValue: () -> SubViewInfo) {
        value = nextValue()
    }
}

struct P258_CustomPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        P258_CustomPreferenceKey()
    }
}
