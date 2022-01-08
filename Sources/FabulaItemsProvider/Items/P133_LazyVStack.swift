//
//  P133_LazyVStack.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P133_LazyVStack: View {
    
    public init() {}
    public var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
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
                .padding(.trailing, 10)
            }
        }
        .padding()
    }
}

struct P133_LazyVStack_Previews: PreviewProvider {
    static var previews: some View {
        P133_LazyVStack()
    }
}
