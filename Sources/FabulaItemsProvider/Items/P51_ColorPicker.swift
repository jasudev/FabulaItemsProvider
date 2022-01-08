//
//  P51_ColorPicker.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P51_ColorPicker: View {
    
    @State private var currentColor = Color.clear
    
    public init() {}
    public var body: some View {
        ZStack {
            currentColor
            ColorPicker("Select Color", selection: $currentColor.animation())
                .frame(maxWidth: 300)
                .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct P51_ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        P51_ColorPicker()
    }
}
