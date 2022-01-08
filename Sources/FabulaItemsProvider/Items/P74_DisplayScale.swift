//
//  P74_DisplayScale.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P74_DisplayScale: View {
    
    @Environment(\.displayScale) private var displayScale: CGFloat
    
    public init() {}
    public var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("displayScale")
                .font(.caption)
                .opacity(0.5)
            Text("\(displayScale)")
        }
    }
}

struct P74_DisplayScale_Previews: PreviewProvider {
    static var previews: some View {
        P74_DisplayScale()
    }
}
