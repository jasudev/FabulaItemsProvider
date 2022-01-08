//
//  P99_DisableAutocorrection.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P99_DisableAutocorrection: View {
    
    @State private var name = ""
    
    public init() {}
    public var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("disableAutocorrection == true")
                    .font(.callout)
                    .opacity(0.5)
                TextField("Enter your name", text: $name)
                    .disableAutocorrection(true)
            }
            Divider()
                .padding()
            VStack(alignment: .leading) {
                Text("disableAutocorrection == false")
                    .font(.callout)
                    .opacity(0.5)
                TextField("Enter your name", text: $name)
                    .disableAutocorrection(false)
            }
        }
        .frame(maxWidth: 500)
        .padding()
    }
}

struct P99_DisableAutocorrection_Previews: PreviewProvider {
    static var previews: some View {
        P99_DisableAutocorrection()
    }
}
