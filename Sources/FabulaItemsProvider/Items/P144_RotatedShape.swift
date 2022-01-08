//
//  P144_RotatedShape.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P144_RotatedShape: View {
    
    let shape = Rectangle().scale(0.5)
    @State private var angle = Angle(degrees: 30)
    
    var rotationGesture: some Gesture {
        RotationGesture()
            .onChanged { angle in
                self.angle = angle
            }
    }
    
    public init() {}
    public var body: some View {
        let rotatedShape = RotatedShape(shape: shape, angle: angle)
        return rotatedShape
            .border(Color.fabulaPrimary)
            .padding()
            .overlay(
                Text("Rotation")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.fabulaPrimary)
            )
            .animation(.easeOut, value: angle)
            .gesture(rotationGesture)
    }
}

struct P144_RotatedShape_Previews: PreviewProvider {
    static var previews: some View {
        P144_RotatedShape()
    }
}
