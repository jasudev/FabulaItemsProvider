//
//  P62_DropDelegate.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P62_DropDelegate: View {
    
    @State private var basket: String = ""
    
    public init() {}
    public var body: some View {
        VStack {
            Text(basket)
                .font(.largeTitle)
                .frame(maxWidth: 300)
            Divider()
            HStack {
                VStack(spacing: 10) {
                    Text("📦")
                        .scaleEffect(2)
                        .onDrag { NSItemProvider(object: self.basket as NSString) }
                        .frame(width: 200, height: 200)
                    Text("DRAG")
                }
                Divider()
                VStack(spacing: 10) {
                    Circle()
                        .frame(width: 150, height: 150)
                        .opacity(0.3)
                        .frame(width: 200, height: 200)
                        .onDrop(of: [.text], delegate: FoodDropDelegate(basket: $basket))
                    Text("DROP")
                }
            }
            .animation(.spring(), value: basket)
        }
        .frame(maxWidth: 400, maxHeight: 400)
    }
}

fileprivate
struct FoodDropDelegate: DropDelegate {
    
    @Binding var basket: String
    
    let foods: String = "🍏🍎🍐🍊🍋🍌🍉🍇🍓🫐🍈🍒🍑🥭🍍🥥🥝🍅🍆🥑🥦🥬🥒🌶🫑🌽🥕🫒🧄🧅🥔🍠🥐🥯🍞🥖🥨🧀🥚🍳🧈🥞🧇🥓🥩🍗🍖🦴🌭🍔🍟🍕🫓🥪🥙🧆🌮🌯🫔🥗🥘🫕"
    
    func performDrop(info: DropInfo) -> Bool {
        self.basket += String(foods.randomElement()!)
        return true
    }
}

struct P62_DropDelegate_Previews: PreviewProvider {
    static var previews: some View {
        P62_DropDelegate()
    }
}
