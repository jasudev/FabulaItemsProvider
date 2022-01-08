//
//  P154_Slider.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P154_Slider: View {
    
    @State private var positionX = 0.5
    @State private var isEditing = false
    
    public init() {}
    public var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack {
                    Circle()
                        .fill(Color.fabulaPrimary)
                        .frame(width: 50, height: 50)
                    Text("\(positionX)")
                        .foregroundColor(isEditing ? .red : .blue)
                }
                .position(x: proxy.size.width * positionX,
                          y: 100 * sin(positionX * CGFloat.pi * 2))
                .animation(.easeInOut, value: positionX)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.bottom, 200)

            Slider(
                value: $positionX,
                in: 0...1,
                onEditingChanged: { editing in
                    isEditing = editing
                }
            )
        }
        .padding()
        .padding(.horizontal, 50)
        .frame(maxWidth: 500)
    }
}

struct P154_Slider_Previews: PreviewProvider {
    static var previews: some View {
        P154_Slider()
    }
}
