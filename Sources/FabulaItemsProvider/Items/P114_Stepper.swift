//
//  P114_Stepper.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P114_Stepper: View {
    
    @State private var value = 0
    
    let step = 10
    let range = 0...100
    
    public init() {}
    public var body: some View {
        Stepper(value: $value, in: range, step: step) {
            Text("Current: ")
            + Text("\(value)")
                .foregroundColor(Color.fabulaPrimary)
            + Text(" in \(range.description) " + "stepping by \(step)")
        }
        .padding()
        .animation(.easeInOut, value: value)
    }
}

struct P114_Stepper_Previews: PreviewProvider {
    static var previews: some View {
        P114_Stepper()
    }
}
