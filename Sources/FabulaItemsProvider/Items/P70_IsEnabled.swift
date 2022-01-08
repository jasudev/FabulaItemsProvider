//
//  P70_IsEnabled.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P70_IsEnabled: View {
    
    public init() {}
    public var body: some View {
        VStack {
            Button {} label: {
                Text("Enabled == true")
            }
            .padding()
            .disabled(false)
            .buttonStyle(EnabledButtonStyle())
            
            Button {} label: {
                Text("Enabled == false")
            }
            .padding()
            .disabled(true)
            .buttonStyle(EnabledButtonStyle())
        }
    }
}

fileprivate
struct EnabledButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(isEnabled ? .accentColor : .gray)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut, value: configuration.isPressed)
    }
}

struct P70_IsEnabled_Previews: PreviewProvider {
    static var previews: some View {
        P70_IsEnabled()
    }
}
