//
//  P214_TextFieldClear.swift
//  
//
//  Created by jasu on 2022/01/30.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P214_TextFieldClear: View {
    
    @State private var text: String = ""
    
    public init() {}
    public var body: some View {
        TextField("ClearButton", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .modifier(ClearButton(text: $text))
    }
}

fileprivate
struct ClearButton: ViewModifier {
    @Binding var text: String
   
    public func body(content: Content) -> some View {
        HStack {
            content
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color.fabulaFore2)
                }
                .buttonStyle(PlainButtonStyle())
                .transition(.scale.combined(with: .opacity))
            }
        }
        .padding()
        .animation(.easeOut(duration: 0.3), value: text)
    }
}

struct P214_TextFieldClear_Previews: PreviewProvider {
    static var previews: some View {
        P214_TextFieldClear()
    }
}
