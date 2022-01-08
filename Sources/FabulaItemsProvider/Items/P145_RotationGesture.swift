//
//  P145_RotationGesture.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P145_RotationGesture: View {
    
    @State private var angle = Angle(degrees: 0.0)
    
    var rotationGesture: some Gesture {
        RotationGesture()
            .onChanged { angle in
                self.angle = angle
            }
    }
    
    public init() {}
    public var body: some View {
        Rectangle()
            .frame(width: 250, height: 250)
            .rotationEffect(self.angle)
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

struct P145_RotationGesture_Previews: PreviewProvider {
    static var previews: some View {
        P145_RotationGesture()
    }
}
