//
//  P60_Divider.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P60_Divider: View {
    
    public init() {}
    public var body: some View {
        HStack {
            VStack {
                Text("Space 1")
                Divider().background(Color.green)
                Text("Space 2")
            }
            Divider().background(Color.red)
            VStack {
                Text("Space 3")
                Divider().background(Color.blue)
                Text("Space 4")
            }
        }
        .padding()
        .frame(maxWidth: 400, maxHeight: 400)
    }
}

struct P60_Divider_Previews: PreviewProvider {
    static var previews: some View {
        P60_Divider()
    }
}
