//
//  P195_BoundsPreferenceKey.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P195_BoundsPreferenceKey: View {

    public init() {}
    public var body: some View {
        ZStack {
            Color.clear
                .border(Color.fabulaPrimary, width: 1)
            Text("BoundsPreferenceKey")
                .foregroundColor(Color.white)
                .padding()
                .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { $0 }
        }
        .frame(width: 300, height: 300)
        .backgroundPreferenceValue(BoundsPreferenceKey.self) { prefers in
            GeometryReader { proxy in
                prefers.map {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: proxy[$0].width, height: proxy[$0].height)
                        .offset(x: proxy[$0].minX, y: proxy[$0].minY)
                }
            }
        }
        .overlayPreferenceValue(BoundsPreferenceKey.self) { prefers in
            GeometryReader { proxy in
                prefers.map {
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                        .frame(width: proxy[$0].width, height: proxy[$0].height)
                        .offset(x: proxy[$0].minX, y: proxy[$0].minY)
                }
            }
        }
    }
}

fileprivate
struct BoundsPreferenceKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?
    static var defaultValue: Value = nil
    static func reduce(value: inout Value,  nextValue: () -> Value) {
        value = nextValue()
    }
}

struct P195_BoundsPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        P195_BoundsPreferenceKey()
    }
}
