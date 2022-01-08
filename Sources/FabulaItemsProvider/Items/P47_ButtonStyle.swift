//
//  P47_ButtonStyle.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P47_ButtonStyle: View {
    
    public init() {}
    public var body: some View {
        VStack(spacing: 12) {
            Button("DefaultButtonStyle", action: action)
                .buttonStyle(DefaultButtonStyle())
            Button("BorderedButtonStyle", action: action)
                .buttonStyle(BorderedButtonStyle())
            Button("PlainButtonStyle", action: action)
                .buttonStyle(PlainButtonStyle())
#if os(macOS)
            if #available(macOS 12.0, *) {
                Button("BorderedProminentButtonStyle", action: action)
                    .buttonStyle(BorderedProminentButtonStyle())
            }
            Button("LinkButtonStyle", action: action)
                .buttonStyle(LinkButtonStyle())
#else
            Button("BorderedProminentButtonStyle", action: action)
                .buttonStyle(BorderedProminentButtonStyle())
#endif
        }
    }
    
    private func action() { }
}

struct P47_ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        P47_ButtonStyle()
    }
}
