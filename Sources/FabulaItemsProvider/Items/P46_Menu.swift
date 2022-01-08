//
//  P46_Menu.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P46_Menu: View {
    
    public init() {}
    public var body: some View {
        VStack(spacing: 10) {
            Menu("DefaultMenuStyle") {
                Button("Menu 1", action: { })
                Button("Menu 2", action: { })
            }
            .menuStyle(DefaultMenuStyle())
            Menu("BorderlessButtonMenuStyle") {
                Button("Menu 1", action: { })
                Button("Menu 2", action: { })
            }
            .menuStyle(BorderlessButtonMenuStyle())
        }
        .frame(maxWidth: 600)
    }
}

struct P46_Menu_Previews: PreviewProvider {
    static var previews: some View {
        P46_Menu()
    }
}
