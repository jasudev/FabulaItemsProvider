//
//  P119_EquatableView.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P119_EquatableView: View {
    
    @State private var count1: Int = 0
    @State private var count2: Int = 0
    
    public init() {}
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Original").font(.caption)
                        .opacity(0.5)
                    TestView(count1: $count1, count2: count2)
                }
                Divider().frame(height: 44)
                VStack(alignment: .leading) {
                    Text("EquatableView").font(.caption)
                        .opacity(0.5)
                    EquatableTestView(count1: $count1, count2: count2)
                    //                      .equatable()
                    //                      or
                    //                      EquatableView(content: EquatableTestView(count1: $count1, count2: count2))
                    //                      Since the EquitableTestView structure follows the Equitable protocol, it has the same effect when removed.
                }
            }
            Divider().frame(width: 44)
            Stepper("Count 1", value: $count1)
            Stepper("Count 2", value: $count2)
        }
        .padding()
    }
}

fileprivate
struct TestView: View {
    
    @Binding var count1: Int
    let count2: Int
    
    init(count1: Binding<Int>, count2: Int) {
        _count1 = count1
        self.count2 = count2
        print("TestView inited")
    }
    
    var body: some View {
        VStack {
            Text("count1 : \(count1)")
            Text("count2 : \(count2)")
        }
    }
}

fileprivate
struct EquatableTestView: View, Equatable {
    
    @Binding var count1: Int
    let count2: Int
    
    init(count1: Binding<Int>, count2: Int) {
        _count1 = count1
        self.count2 = count2
        print("EquatableTestView inited")
    }
    
    var body: some View {
        VStack {
            Text("count1 : \(count1)")
            Text("count2 : \(count2)")
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.count1 == rhs.count1
    }
}


struct P119_EquatableView_Previews: PreviewProvider {
    static var previews: some View {
        P119_EquatableView()
    }
}
