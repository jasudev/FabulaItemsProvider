//
//  P54_GroupBox.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P54_GroupBox: View {
    
    public init() {}
    public var body: some View {
        ZStack {
            Color.black.opacity(0.2)
            GroupBox(label: GroupBoxLabel()) {
                Text("GroupBox Content")
                    .padding()
            }
            .padding()
            .frame(maxWidth: 500)
            .padding()
        }
    }
}

fileprivate
struct GroupBoxLabel: View {
    var body: some View {
        HStack {
            Image(systemName: "archivebox")
            Text("Title")
        }
    }
}

struct P54_GroupBox_Previews: PreviewProvider {
    static var previews: some View {
        P54_GroupBox().preferredColorScheme(.dark)
    }
}
