//
//  P217_Publisher.swift
//  
//
//  Created by jasu on 2022/02/02.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import Combine

public struct P217_Publisher: View {
    
    let provider = (0...10).publisher
    @State private var value: String = ""
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading) {
            Text("let provider = (0...10).publisher\n\nprovider.sink { _ in\n        self.value = 'Receive data complete'\n} receiveValue: { value in\n        self.value += '\\\\(value)\\\\n'\n}")
                .font(.headline)
            Divider().frame(width: 44)
            VStack(alignment: .leading) {
                Text("Results : ")
                Text("\(value)")
            }
            .font(.headline)
            .foregroundColor(Color.fabulaPrimary)
        }
        .onAppear {
            let _ = provider.sink { _ in
                self.value += "Receive data complete"
            } receiveValue: { value in
                self.value += "\(value)\n"
            }
        }
    }
}

struct P217_Publisher_Previews: PreviewProvider {
    static var previews: some View {
        P217_Publisher()
    }
}
