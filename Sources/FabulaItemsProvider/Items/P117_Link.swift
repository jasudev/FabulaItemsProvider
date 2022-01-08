//
//  P117_Link.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P117_Link: View {
    
    public init() {}
    public var body: some View {
        Link("Fabula App Link",
              destination: URL(string: "https://apps.apple.com/app/id1591155142")!)
    }
}

struct P117_Link_Previews: PreviewProvider {
    static var previews: some View {
        P117_Link()
    }
}
