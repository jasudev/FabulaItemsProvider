//
//  P192_FractalBasic.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P192_FractalBasic: View {
    
    public init() {}
    public var body: some View {
        Item(count: 2)
            .padding()
    }
}

fileprivate
struct Item: View {
    let count: Int
    
    var body: some View {
        if count <= 0 {
            Rectangle()
                .fill(Color.random)
        }else {
            GeometryReader { proxy in
                let min = min(proxy.size.width, proxy.size.height)
                ZStack {
                    Color.clear
                    VStack {
                        HStack {
                            Item(count: count - 1)
                            Item(count: count - 1)
                            Item(count: count - 1)
                        }
                        HStack {
                            Item(count: count - 1)
                            Item(count: count - 1).hidden()
                            Item(count: count - 1)
                        }
                        
                        HStack {
                            Item(count: count - 1)
                            Item(count: count - 1)
                            Item(count: count - 1)
                        }
                    }
                    .frame(width: min, height: min)
                }
            }
        }
    }
}

struct P192_FractalBasic_Previews: PreviewProvider {
    static var previews: some View {
        P192_FractalBasic()
    }
}
