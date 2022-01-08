//
//  P140_OffsetShape.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P140_OffsetShape: View {
    
    public init() {}
    public var body: some View {
        OffsetShape(shape: Circle(), offset: CGSize(width: 50, height: 0))
    }
}

struct P140_OffsetShape_Previews: PreviewProvider {
    static var previews: some View {
        P140_OffsetShape()
    }
}
