//
//  P89_KeyboardShortcut.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P89_KeyboardShortcut: View {
    
    @State private var text: String = "🍑"
    
    public init() {}
    public var body: some View {
        if #available(macOS 12.0, *) {
            VStack {
                Text(text)
                    .font(.largeTitle)
                Divider()
                    .frame(width: 44)
                    .padding()
                Button {
                    withAnimation {
                        text += "🍑"
                    }
                } label: {
                    Text("ShortcutButton - Enter Key")
                }
                .keyboardShortcut(.defaultAction)
                Divider()
                    .frame(width: 44)
                    .padding()
                Button {
                    print("Action")
                } label: {
                    Text("ShortcutButton")
                }
            }
            .buttonStyle(ShortcutButtonStyle())
            .padding()
        } else {
            Button {
                print("Action")
            } label: {
                Text("Availability\niOS 15.0+\niPadOS 15.0+\nmacOS 12.0+\nMac Catalyst 15.0+")
            }
        }
    }
}

@available(macOS 12.0, *)
fileprivate
struct ShortcutButtonStyle: ButtonStyle {
    
    @Environment(\.keyboardShortcut) private var shortcut: KeyboardShortcut?

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(shortcut == .defaultAction ? Color.fabulaPrimary : Color.gray)
    }
}

struct P89_KeyboardShortcut_Previews: PreviewProvider {
    static var previews: some View {
        P89_KeyboardShortcut()
    }
}
