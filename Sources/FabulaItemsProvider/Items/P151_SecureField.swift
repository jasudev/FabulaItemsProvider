//
//  P151_SecureField.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P151_SecureField: View {
    
    @State private var password = ""
    @State private var message = ""
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Password : ") + Text("\(password)").foregroundColor(Color.fabulaPrimary)
            Text("Return Message : ") + Text("\(message)").foregroundColor(Color.fabulaPrimary)
            Divider().padding()
            SecureField("Password", text: $password, onCommit: {
                message = "Completed!"
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
        .animation(.easeInOut, value: password)
        .frame(maxWidth: 500)
    }
}

struct P151_SecureField_Previews: PreviewProvider {
    static var previews: some View {
        P151_SecureField()
    }
}
