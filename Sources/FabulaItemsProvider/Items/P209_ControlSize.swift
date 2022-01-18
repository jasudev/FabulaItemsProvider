//
//  P209_ControlSize.swift
//  
//
//  Created by jasu on 2022/01/18.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P209_ControlSize: View {
    
    public init() {}
    public var body: some View {
        VStack {
            SliderControls(label: "Mini")
                .controlSize(.mini)
            SliderControls(label: "Small")
                .controlSize(.small)
            SliderControls(label: "Regular")
                .controlSize(.regular)
            SliderControls(label: "Large")
                .controlSize(.large)
        }
        .padding()
        .frame(maxWidth: 500)
        .border(Color.gray)
    }
}

fileprivate
struct SliderControls: View {
    
    var label: String
    @State private var value = 3.0
    @State private var selectedOption = 1
    
    var body: some View {
        HStack {
            Text(label + " :")
            Picker("Selection", selection: $selectedOption) {
                Text("option 1").tag(1)
                Text("option 2").tag(2)
                Text("option 3").tag(3)
            }
            Slider(value: $value, in: 1...10)
            Button("OK") { }
        }
    }
}

struct P209_ControlSize_Previews: PreviewProvider {
    static var previews: some View {
        P209_ControlSize()
    }
}
