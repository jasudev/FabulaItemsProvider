//
//  GeometryProxy+Extensions.swift
//  Fabula
//
//  Created by jasu on 2022/01/01.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public extension GeometryProxy {
    var minSize: CGFloat {
        min(self.size.width, self.size.height)
    }
    
    var maxSize: CGFloat {
        max(self.size.width, self.size.height)
    }
}
