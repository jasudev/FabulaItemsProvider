//
//  P159_TapGesture.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P159_TapGesture: View {
    
    @State var tapped = false
    
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in self.tapped = !self.tapped }
    }
    
    public init() {}
    public var body: some View {
        Circle()
            .fill(self.tapped ? Color.blue : Color.red)
            .frame(width: 200, height: 200, alignment: .center)
            .overlay(
                Text("Tap")
                    .bold()
            )
            .gesture(tap)
    }
}

struct P159_TapGesture_Previews: PreviewProvider {
    static var previews: some View {
        P159_TapGesture()
    }
}
