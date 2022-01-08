//
//  P87_IsSearching.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

#if os(iOS)
public struct P87_IsSearching: View {
    
    @State private var text = ""
    
    public init() {}
    public var body: some View {
        VStack {
            Text(text)
            Divider()
                .frame(width: 44)
                .padding()
            SearchReadingView()
                .searchable(text: $text.animation())
        }
        .padding()
    }
}

fileprivate
struct SearchReadingView: View {
    
    @Environment(\.isSearching) private var isSearching
    
    var body: some View {
        ZStack {
            if isSearching {
                Text("Searching!")
                    .foregroundColor(Color.fabulaPrimary)
            } else {
                Text("Not searching.")
                    .opacity(0.5)
            }
        }
        .animation(.easeInOut, value: isSearching)
    }
}

#else
public struct P87_IsSearching: View {
    
    public init() {}
    public var body: some View {
        EmptyView()
    }
}
#endif

struct P87_IsSearching_Previews: PreviewProvider {
    static var previews: some View {
        P87_IsSearching()
    }
}
