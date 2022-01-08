//
//  P53_ContextMenu.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P53_ContextMenu: View {
    
    @State private var actionTitle: String = "-"
    
    var menuItems: some View {
        Group {
            Section {
                Button("1. Button", action: select1)
                Button("2. Button", action: select2)
            }
            Section {
                Button("3. Button", action: select3)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    public init() {}
    public var body: some View {
        VStack(spacing: 25) {
            Text(actionTitle)
                .font(.title)
                .foregroundColor(actionTitle == "-" ? Color.gray.opacity(0.5) : Color.fabulaPrimary)
            Divider().frame(width: 44)
            Text(getButtonTitle())
                .contextMenu {
                    menuItems
                }
        }
        .padding()
    }
    
    private func getButtonTitle() -> String {
#if os(iOS)
        return "Long Press"
#else
        return "Right Click"
#endif
    }
    
    private func select1() {
        actionTitle = "Button 1"
    }
    private func select2() {
        actionTitle = "Button 2"
    }
    private func select3() {
        actionTitle = "Button 3"
    }
}

struct P53_ContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        P53_ContextMenu()
    }
}
