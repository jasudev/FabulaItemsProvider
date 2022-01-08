//
//  P136_LongPressGesture.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P136_LongPressGesture: View {
    
    @GestureState var isDetectingLongPress = false
    @State var completedLongPress = false
    
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 3)
            .updating($isDetectingLongPress) { currentstate, gestureState,
                transaction in
                gestureState = currentstate
                transaction.animation = Animation.easeIn(duration: 2.0)
            }
            .onEnded { finished in
                self.completedLongPress = finished
            }
    }
    
    public init() {}
    public var body: some View {
        Circle()
            .fill(self.isDetectingLongPress ?
                  Color.red :
                    (self.completedLongPress ? Color.green : Color.blue))
            .frame(width: 100, height: 100, alignment: .center)
            .gesture(longPress)
    }
}

struct P136_LongPressGesture_Previews: PreviewProvider {
    static var previews: some View {
        P136_LongPressGesture()
    }
}
