//
//  P78_PixelLength.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P78_PixelLength: View {
    
    @Environment(\.pixelLength) private var pixelLength: CGFloat
    
    public init() {}
    public var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(".pixelLength")
                .font(.caption)
                .opacity(0.5)
            Text("\(pixelLength)")
        }
    }
}

struct P78_PixelLength_Previews: PreviewProvider {
    static var previews: some View {
        P78_PixelLength()
    }
}
