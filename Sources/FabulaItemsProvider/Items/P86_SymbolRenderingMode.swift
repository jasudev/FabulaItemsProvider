//
//  P86_SymbolRenderingMode.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P86_SymbolRenderingMode: View {
    
    public init() {}
    public var body: some View {
#if os(iOS)
        VStack(spacing: 20) {
            Image(systemName: "person.3.sequence.fill")
                .imageScale(.large)
            HStack {
                Image(systemName: "person.3.sequence.fill")
                    .imageScale(.large)
                    .environment(\.symbolRenderingMode, .palette)
                Text(".palette")
            }
            HStack {
                Image(systemName: "person.3.sequence.fill")
                    .imageScale(.large)
                    .environment(\.symbolRenderingMode, .hierarchical)
                Text(".hierarchical")
            }
            HStack {
                Image(systemName: "person.3.sequence.fill")
                    .imageScale(.large)
                    .environment(\.symbolRenderingMode, .monochrome)
                Text(".monochrome")
            }
            HStack {
                Image(systemName: "person.3.sequence.fill")
                    .imageScale(.large)
                    .environment(\.symbolRenderingMode, .multicolor)
                Text(".multicolor")
            }
            HStack {
                Image(systemName: "person.3.sequence.fill")
                    .imageScale(.large)
                    .environment(\.symbolRenderingMode, .none)
                Text(".none")
            }
        }
        .foregroundStyle(.red, .green, .blue)
#else
        EmptyView()
#endif
    }
}

struct P86_SymbolRenderingMode_Previews: PreviewProvider {
    static var previews: some View {
        P86_SymbolRenderingMode()
    }
}
