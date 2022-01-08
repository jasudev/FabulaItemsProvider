//
//  P152_SequenceGesture.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P152_SequenceGesture: View {
    
    @State private var message = "Long press & drag"
    @State private var position: CGPoint? = nil
    
    public init() {}
    public var body: some View {
        let longPress = LongPressGesture()
            .onEnded { _ in
                message = "Drag is possible"
            }
        
        let drag = DragGesture()
            .onEnded { _ in
                message = "Long press & drag"
            }
            .onChanged { value in
                message = "Dragging"
                position = value.location
            }
        
        GeometryReader { proxy in
            VStack {
                Text(message)
                    .fontWeight(.bold)
                    .foregroundColor(Color.fabulaPrimary)
                Circle()
                    .frame(width: 100, height: 100)
            }
            .position(position ?? CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2))
            .animation(.easeOut, value: position)
            .gesture(longPress.sequenced(before: drag))
        }
    }
}

struct P152_SequenceGesture_Previews: PreviewProvider {
    static var previews: some View {
        P152_SequenceGesture()
    }
}
