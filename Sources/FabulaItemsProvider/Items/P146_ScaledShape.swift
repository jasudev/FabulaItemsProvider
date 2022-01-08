//
//  P146_ScaledShape.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P146_ScaledShape: View {
    
    @State private var scale = CGSize(width: 0.5, height: 0.5)
    
    var scaleGesture: some Gesture {
        MagnificationGesture()
            .onChanged { size in
                scale = CGSize(width: size, height: size)
            }
    }
    
    public init() {}
    public var body: some View {
        ScaledShape(shape: Rectangle(), scale: scale)
            .border(Color.orange)
            .padding()
            .overlay(
                Text("Pitch")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.fabulaPrimary)
            )
            .animation(.easeOut, value: scale)
            .gesture(scaleGesture)
    }
}

struct P146_ScaledShape_Previews: PreviewProvider {
    static var previews: some View {
        P146_ScaledShape()
    }
}
