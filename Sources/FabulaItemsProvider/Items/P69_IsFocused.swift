//
//  P69_IsFocused.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P69_IsFocused: View {
    
    public init() {}
    public var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(0..<30) { index in
                    Post()
                }
            }
        }
    }
}

fileprivate
struct Post: View {
    
    @Environment(\.isFocused) var isFocused
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 150, height: 100)
#if os(macOS)
            .foregroundColor(isFocused ? Color.fabulaPrimary : Color.gray)
#endif
            .animation(.easeInOut, value: isFocused)
    }
}

struct P69_IsFocused_Previews: PreviewProvider {
    static var previews: some View {
        P69_IsFocused()
    }
}
