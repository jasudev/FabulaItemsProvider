//
//  P137_MagnificationGesture.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P137_MagnificationGesture: View {
    
    @GestureState var magnifyBy: CGFloat = 1.0
    
    var magnification: some Gesture {
        MagnificationGesture()
            .updating($magnifyBy) { currentState, gestureState, transaction in
                gestureState = currentState
            }
    }
    
    public init() {}
    public var body: some View {
        Circle()
            .frame(width: 200 * magnifyBy,
                   height: 200 * magnifyBy,
                   alignment: .center)
            .overlay(
                Text("Pitch".uppercased())
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.fabulaPrimary)
            )
            .gesture(magnification)
            .animation(.easeInOut, value: magnifyBy)
    }
}

struct P137_MagnificationGesture_Previews: PreviewProvider {
    static var previews: some View {
        P137_MagnificationGesture()
    }
}
