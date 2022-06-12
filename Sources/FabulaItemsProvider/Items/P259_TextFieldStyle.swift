//
//  P259_TextFieldStyle.swift
//  
//
//  Created by jasu on 2022/06/01.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P259_TextFieldStyle: View {
    
    @State private var text = ""
    
    public init() {}
    public var body: some View {
        VStack {
            Text("Text: \(text)")
            Divider()
            TextField(".plain", text: $text)
                .textFieldStyle(.plain)
            TextField(".automatic", text: $text)
                .textFieldStyle(.automatic)
            TextField(".roundedBorder", text: $text)
                .textFieldStyle(.roundedBorder)
#if os(macOS)
            TextField(".squareBorder", text: $text)
                .textFieldStyle(.squareBorder)
#endif
        }
        .padding()
    }
}

struct P259_TextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        P259_TextFieldStyle()
    }
}
