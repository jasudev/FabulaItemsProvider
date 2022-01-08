//
//  P113_Popover.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P113_Popover: View {
    
    @State private var isShowPopover = false
    
    public init() {}
    public var body: some View {
        Button("Show Popover", action: {
            self.isShowPopover = true
        })
            .padding(10)
            .popover(isPresented: $isShowPopover) {
                PopoverDetailView()
            }
    }
}

fileprivate
struct PopoverDetailView: View {
    var body: some View {
        Text("Popover Content")
            .padding()
    }
}

struct P113_Popover_Previews: PreviewProvider {
    static var previews: some View {
        P113_Popover()
    }
}
