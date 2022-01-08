//
//  P0_Example.swift
//  Fabula
//
//  Created by jasu on 2022/01/05.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P0_Example: View {
    
    public init() {}
    public var body: some View {
        VStack {
            ExampleSubView1()
            ExampleSubView2()
        }
    }
}

fileprivate
struct ExampleSubView1: View {
    var body: some View {
        Text("Hello, World!")
    }
}

fileprivate
struct ExampleSubView2: View {
    var body: some View {
        Text("Hello, Fabula!")
    }
}

struct P0_Example_Previews: PreviewProvider {
    static var previews: some View {
        P0_Example()
    }
}
