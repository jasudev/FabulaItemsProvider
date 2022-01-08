//
//  P131_LazyVGrid.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P131_LazyVGrid: View {
    
    var rows: [GridItem] = Array(repeating: .init(.fixed(80), spacing: 5), count: 2)
    
    public init() {}
    public var body: some View {
        ZStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: rows, spacing: 5) {
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
                                .foregroundColor(Color.black)
                        }
                        .frame(width: 80, height: 80)
                    }
                    .background(Color.white)
                }
                .padding(5)
                .background(Color.fabulaPrimary)
                .fixedSize()
                .padding(.trailing, 10)
            }
        }
        .padding()
    }
}

struct P131_LazyVGrid_Previews: PreviewProvider {
    static var previews: some View {
        P131_LazyVGrid()
    }
}
