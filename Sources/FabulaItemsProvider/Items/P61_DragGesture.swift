//
//  P61_DragGesture.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P61_DragGesture: View {
    
    @State private var location: CGPoint = .zero
    @State var isDragging = false
    
    private var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.location = value.location
                self.isDragging = true
            }
            .onEnded {_ in self.isDragging = false}
    }
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            Circle()
                .fill(self.isDragging ? Color.fabulaPrimary : Color.black.opacity(0.5))
                .frame(width: 80, height: 80)
                .overlay(
                    Text("DRAG")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                )
                .scaleEffect(isDragging ? 1.1 : 1.0)
                .position(location)
                .animation(.spring(), value: isDragging)
                .gesture(drag)
                .onAppear {
                    DispatchQueue.main.async {
                        location = CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2)
                    }
                }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct P61_DragGesture_Previews: PreviewProvider {
    static var previews: some View {
        P61_DragGesture()
    }
}
