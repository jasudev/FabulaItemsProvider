//
//  P210_ZoomModifier.swift
//  
//
//  Created by jasu on 2022/01/24.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P210_ZoomModifier: View {
    
    public init() {}
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(width: 300, height: 300)
            .background(Color.fabulaSecondary)
            .modifier(ZoomModifier(minimum: 0.5, maximum: 5.0))
    }
}

fileprivate
struct ZoomModifier: ViewModifier {
    enum ZoomState {
        case inactive
        case active(scale: CGFloat)

        var scale: CGFloat {
            switch self {
            case .active(let scale):
                return scale
            default:
                return 1.0
            }
        }
    }
    
    var minimum: CGFloat = 1.0
    var maximum: CGFloat = 3.0
    
    @GestureState private var zoomState = ZoomState.inactive
    @State private var currentScale: CGFloat = 1.0
    
    var scale: CGFloat {
        return currentScale * zoomState.scale
    }
    
    var pinchGesture: some Gesture {
        MagnificationGesture()
            .updating($zoomState) { value, state, transaction in
                state = .active(scale: value)
            }.onEnded { value in
                var newValue = self.currentScale * value
                if newValue <= minimum { newValue = minimum }
                if newValue >= maximum { newValue = maximum }
                self.currentScale = newValue
            }
    }
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .gesture(pinchGesture)
            .animation(.easeInOut, value: scale)
    }
}

struct P210_ZoomModifier_Previews: PreviewProvider {
    static var previews: some View {
        P210_ZoomModifier()
    }
}
