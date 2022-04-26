//
//  P237_InitialState.swift
//  
//
//  Created by jasu on 2022/04/26.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P237_InitialState: View {
    
    public init() {}
    public var body: some View {
        Example(value: 10.0)
    }
}

fileprivate
struct Example: View {
    
    @State private var value: CGFloat = 0
    
    init(value: CGFloat) {
        _value = State(initialValue: value)
    }
    
    var body: some View {
        Text("Initial Value : \(value)")
    }
}

struct P237_InitialState_Previews: PreviewProvider {
    static var previews: some View {
        P237_InitialState()
    }
}
