//
//  P169_TupleView.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P169_TupleView: View {
    
    public init() {}
    public var body: some View {
        CustomTupleView {
            Text("First").foregroundColor(.red)
            Text("Second").foregroundColor(.green)
            Text("Third").foregroundColor(.blue)
        }
    }
}

fileprivate
extension P169_TupleView {
    struct CustomTupleView<First: View, Second: View, Third: View>: View {
        
        let first: First
        let second: Second
        let third: Third
        
        init(@ViewBuilder content: () -> TupleView<(First, Second, Third)>) {
            let views = content().value
            first = views.0
            second = views.1
            third = views.2
        }
        
        var body: some View {
            VStack {
                first
                Divider()
                    .frame(width: 44)
                    .padding()
                second
                Divider()
                    .frame(width: 44)
                    .padding()
                third
            }
        }
    }
}

struct P169_TupleView_Previews: PreviewProvider {
    static var previews: some View {
        P169_TupleView()
    }
}
