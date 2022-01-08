//
//  P128_ImagePaint.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P128_ImagePaint: View {
    
    public init() {}
    public var body: some View {
        ZStack {
            if #available(macOS 12.0, *) {
                Rectangle()
                    .fill(ImagePaint(image: Image(systemName: "bicycle.circle")))
            }else {
                Text("Rectangle().fill(ImagePaint(image: Image('image')))")
            }
        }
        .background(Color.green)
    }
}

struct P128_ImagePaint_Previews: PreviewProvider {
    static var previews: some View {
        P128_ImagePaint()
    }
}
