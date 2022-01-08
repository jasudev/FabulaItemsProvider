//
//  P85_SymbolVariants.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P85_SymbolVariants: View {
    
    public init() {}
    public var body: some View {
#if os(iOS)
        HStack {
            Image(systemName: "heart")
                .imageScale(.large)
            
            Image(systemName: "heart")
                .imageScale(.large)
                .environment(\.symbolVariants, .square)
            Image(systemName: "heart")
                .imageScale(.large)
                .environment(\.symbolVariants, .circle)
            Image(systemName: "heart")
                .imageScale(.large)
                .environment(\.symbolVariants, .none)
            Image(systemName: "heart")
                .imageScale(.large)
                .environment(\.symbolVariants, .rectangle)
            Image(systemName: "heart")
                .imageScale(.large)
                .environment(\.symbolVariants, .slash)
        }
        .symbolVariant(.fill)
        .foregroundColor(Color.fabulaPrimary)
#else
        EmptyView()
#endif
    }
}

struct P85_SymbolVariants_Previews: PreviewProvider {
    static var previews: some View {
        P85_SymbolVariants()
    }
}
