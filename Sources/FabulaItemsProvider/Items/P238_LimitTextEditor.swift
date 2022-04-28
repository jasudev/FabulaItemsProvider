//
//  P238_LimitTextEditor.swift
//  
//
//  Created by jasu on 2022/04/26.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P238_LimitTextEditor: View {
    
    @State private var limitNumber: Int = 30
    @State private var baseText: String = "Text"
    
    public init() {}
    public var body: some View {
        let text = Binding(
            get: { self.baseText },
            set: { self.baseText = String($0.prefix(limitNumber)).components(separatedBy: .newlines).joined() }
        )
        VStack {
            Text("Number of characters : \(text.wrappedValue.count)")
                .foregroundColor(text.wrappedValue.count == limitNumber ? .red : .fabulaForeWB100)
            Rectangle()
                .fill(Color.fabulaFore2)
                .overlay(
                    TextEditor(text: text)
                        .padding(1)
                )
        }
        .padding()
    }
}

struct P238_LimitTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        P238_LimitTextEditor()
    }
}
