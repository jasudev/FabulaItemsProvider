//
//  P132_LazyHStack.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P132_LazyHStack: View {
    
    public init() {}
    public var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top) {
                    ForEach((0...79), id: \.self) {
                        let codepoint = $0 + 0x1f600
                        let codepointString = String(format: "%02X", codepoint)
                        let emoji = String(Character(UnicodeScalar(codepoint)!))
                        VStack {
                            Text("\(emoji)")
                                .font(.largeTitle)
                                .environment(\.imageScale, .large)
                            Text("\(codepointString)")
                                .font(.footnote)
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 80, height: 80)
                    }
                    .background(Color.fabulaPrimary)
                }
                .fixedSize()
                .padding(.bottom, 10)
            }
        }
        .padding()
    }
}

struct P132_LazyHStack_Previews: PreviewProvider {
    static var previews: some View {
        P132_LazyHStack()
    }
}
