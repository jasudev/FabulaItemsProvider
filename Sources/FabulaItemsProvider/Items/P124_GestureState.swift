//
//  P124_GestureState.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P124_GestureState: View {
    
    @GestureState var isDetectingLongPress = false
    
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 2)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
            }
    }
    
    public init() {}
    public var body: some View {
        Circle()
            .fill(self.isDetectingLongPress ? Color.red : Color.green)
            .frame(width: 100, height: 100, alignment: .center)
            .scaleEffect(isDetectingLongPress ? 1.5 : 1.0)
            .gesture(longPress)
            .animation(.easeInOut, value: isDetectingLongPress)
    }
}

struct P124_GestureState_Previews: PreviewProvider {
    static var previews: some View {
        P124_GestureState()
    }
}
