//
//  P257_InsettableShape.swift
//  
//
//  Created by jasu on 2022/05/25.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P257_InsettableShape: View {
    
    public init() {}
    public var body: some View {
        HStack {
            VStack {
                RactangleView(duration: 3.0)
                RactangleView(duration: 3.5)
            }
            VStack {
                RactangleView(duration: 4.0)
                RactangleView(duration: 4.5)
            }
        }
    }
}

fileprivate
struct RactangleView: View {
    
    @State private var value: CGFloat = 0
    @State private var color: Color = Bool.random() ? Color.fabulaSecondary : Color.fabulaPrimary
    private let size: CGFloat = 100
    let duration: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .inset(by: value)
            .fill(color)
            .frame(width: size, height: size)
            .border(color)
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(Animation.easeInOut(duration: duration).repeatForever()) {
                        value = size * 0.5
                        color = color == Color.fabulaPrimary ? Color.fabulaSecondary : Color.fabulaPrimary
                    }
                }
            }
    }
}

struct P257_InsettableShape_Previews: PreviewProvider {
    static var previews: some View {
        P257_InsettableShape()
    }
}

