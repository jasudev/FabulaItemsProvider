//
//  P58_Toggle.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P58_Toggle: View {
    
    @State private var status = true
    @State private var styleTag: Int = 0
    
    public init() {}
    public var body: some View {
        VStack(spacing: 30) {
            if #available(macOS 12.0, *) {
                Toggle(isOn: $status) {
                    Text("ButtonToggleStyle")
                }
                .toggleStyle(ButtonToggleStyle())
                .tint(Color.fabulaPrimary)
                
                Toggle(isOn: $status) {
                    Text("SwitchToggleStyle")
                }
                .toggleStyle(SwitchToggleStyle())
                .tint(Color.fabulaPrimary)
            }
            
            Toggle(isOn: $status) {
                Text("DefaultToggleStyle")
            }
            .toggleStyle(DefaultToggleStyle())
            
            
#if os(macOS)
            Toggle(isOn: $status) {
                Text("CheckboxToggleStyle")
            }
            .toggleStyle(CheckboxToggleStyle())
#endif
        }
        .padding(40)
        .frame(maxWidth: 500)
        .animation(.easeInOut, value: status)
    }
}

struct P58_Toggle_Previews: PreviewProvider {
    static var previews: some View {
        P58_Toggle()
    }
}
