//
//  P175_DragGesture.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P175_DragGesture: View {
    
    @GestureState private var dragAmount = CGSize.zero
    
    public init() {}
    public var body: some View {
        ZStack {
            Color.clear
            VStack {
                Image(systemName: "umbrella.fill")
                    .font(.system(size: 100))
                Text("W: \(Int(dragAmount.width)) · H: \(Int(dragAmount.height))")
            }
            .offset(dragAmount)
            .animation(.easeInOut, value: dragAmount)
        }
        .gesture(
            DragGesture()
                .updating($dragAmount) { value, state, transaction in
                    state = value.translation
                }
        )
    }
}

struct P175_DragGesture_Previews: PreviewProvider {
    static var previews: some View {
        P175_DragGesture()
    }
}
