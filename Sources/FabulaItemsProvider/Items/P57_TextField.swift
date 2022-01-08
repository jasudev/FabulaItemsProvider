//
//  P57_TextField.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P57_TextField: View {
    
    @State private var username: String = "dev.fabula@gmail.com"
    @State private var selectedTag: Int = 0
    
    var textField: some View {
        GroupBox {
            TextField("User name (email address)", text: $username)
                .padding(5)
                .disableAutocorrection(true)
            
        } label: {
            Text("TextField")
                .font(.caption)
                .opacity(0.5)
        }
    }
    
    public init() {}
    public var body: some View {
        VStack {
            VStack {
                Text(username)
                    .foregroundColor(Color.fabulaPrimary)
                
                Divider()
                
                switch selectedTag {
                case 0:
                    textField
                        .textFieldStyle(DefaultTextFieldStyle())
                case 1:
                    textField
                        .textFieldStyle(PlainTextFieldStyle())
                case 2:
                    textField
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                default:
                    EmptyView()
                }
            }
            .padding()
            .background(Color.blue.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            
            Picker("TextFieldStyle", selection: $selectedTag) {
                Text("DefaultTextFieldStyle")
                    .tag(0)
                Text("PlainTextFieldStyle")
                    .tag(1)
                Text("RoundedBorderTextFieldStyle")
                    .tag(2)
            }
#if os(iOS)
            .pickerStyle(WheelPickerStyle())
#else
            .pickerStyle(InlinePickerStyle())
#endif
            .padding()
        }
        .frame(maxWidth: 500)
        .animation(.easeInOut, value: username)
        .animation(.easeInOut, value: selectedTag)
    }
}

struct P57_TextField_Previews: PreviewProvider {
    static var previews: some View {
        P57_TextField()
            .background(Color.fabulaBack1)
            .preferredColorScheme(.dark)
    }
}
