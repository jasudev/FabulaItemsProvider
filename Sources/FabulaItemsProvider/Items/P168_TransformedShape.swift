//
//  P168_TransformedShape.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P168_TransformedShape: View {
    
    @State private var switching: Bool = false
    
    public init() {}
    public var body: some View {
        ZStack {
            if switching {
                TransformedShape(shape: Rectangle(), transform: CGAffineTransform(rotationAngle: 0.5))
                    .fill(Color.blue)
                    .frame(width: 150, height: 150)
                    .background(Color.yellow)
                    .border(Color.orange)
            }else {
                TransformedShape(shape: Rectangle(), transform: CGAffineTransform(rotationAngle: 0))
                    .fill(Color.blue)
                    .frame(width: 150, height: 150)
                    .background(Color.yellow)
                    .border(Color.orange)
            }
        }
        .animation(.easeInOut, value: switching)
        .onTapGesture {
            switching.toggle()
        }
    }
}

struct P168_TransformedShape_Previews: PreviewProvider {
    static var previews: some View {
        P168_TransformedShape()
    }
}
