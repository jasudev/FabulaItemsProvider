//
//  P115_PrimitiveButtonStyle.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P115_PrimitiveButtonStyle: View {
    
    public init() {}
    public var body: some View {
        VStack {
            Button("Button Style 1") { }
            .buttonStyle(LongPrimitiveButtonStyle())
            
            Divider().frame(width: 44)
            
            Button("Button Style 2") { }
            .buttonStyle(LongPrimitiveButtonStyle(minDuration: 1.5, pressedColor: Color.red))
        }
    }
}

fileprivate
struct  LongPrimitiveButtonStyle: PrimitiveButtonStyle {
    
    var minDuration = 0.5
    var pressedColor: Color = Color.blue
    
    func makeBody(configuration: Configuration) -> some View {
        ButtonStyleBody(configuration: configuration,
                        minDuration: minDuration,
                        pressedColor: pressedColor)
    }
    
    private struct ButtonStyleBody: View {
        
        let configuration: Configuration
        let minDuration: CGFloat
        let pressedColor: Color
        @GestureState private var isPressed = false
        
        var body: some View {
            let longPress = LongPressGesture(minimumDuration: minDuration)
                .updating($isPressed) { value, state, _ in
                    state = value
                }
                .onEnded { _ in
                    self.configuration.trigger()
                }
            return configuration.label
                .padding()
                .background(
                    GeometryReader { proxy in
                        RoundedRectangle(cornerRadius: isPressed ? proxy.size.height / 2 : 8)
                            .fill(isPressed ? pressedColor : Color.fabulaPrimary)
                    }
                    
                )
                .foregroundColor(.white)
                .gesture(longPress)
                .scaleEffect(isPressed ? 0.7 : 1.0)
                .animation(.easeInOut, value: isPressed)
        }
    }
}

struct P115_PrimitiveButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        P115_PrimitiveButtonStyle()
    }
}
