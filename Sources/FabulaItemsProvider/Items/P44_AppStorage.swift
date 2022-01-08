//
//  P44_AppStorage.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P44_AppStorage: View {
    
    @AppStorage("P44_AppStorage") var text: String = "한글"
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .center) {
                Text("Stored text:")
                    .font(.caption)
                Text("\(text)")
            }
            TextField(text, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(40)
        .frame(maxWidth: 600)
    }
}

struct P44_AppStorage_Previews: PreviewProvider {
    static var previews: some View {
        P44_AppStorage()
    }
}
