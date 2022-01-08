//
//  P135_ListItemTint.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P135_ListItemTint: View {
    
    public init() {}
    public var body: some View {
        List {
            // A tint Color that cannot be overriden by the system.
            Label("ListItemTint.fixed", systemImage: "cloud.heavyrain.fill")
                .listItemTint(ListItemTint.fixed(Color.orange))
            // A tint Color that can be overriden by the system.
            Label("ListItemTint.preferred", systemImage: "cloud.hail.fill")
                .listItemTint(ListItemTint.preferred(Color.green))
            // The standard gray tint effect.
            Label("ListItemTint.monochrome", systemImage: "cloud.snow.fill")
                .listItemTint(ListItemTint.monochrome)
        }
        .frame(maxWidth: 500, maxHeight: 200)
    }
}

struct P135_ListItemTint_Previews: PreviewProvider {
    static var previews: some View {
        P135_ListItemTint()
    }
}
