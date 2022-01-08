//
//  P110_ConfirmationDialog.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P110_ConfirmationDialog: View {
    
    @State private var isShow = false
    @State private var selectMenu = "None"

    public init() {}
    public var body: some View {
        VStack {
            Text(selectMenu)
                .font(.title)
            if #available(macOS 12.0, *) {
                Button("Show Dialog") {
                    isShow = true
                }
                .confirmationDialog("Select a menu", isPresented: $isShow, titleVisibility: .visible) {
                    Button("Menu 1") {
                        selectMenu = "Menu 1"
                    }
                    
                    Button("Menu 2") {
                        selectMenu = "Menu 2"
                    }
                    
                    Button("Menu 3") {
                        selectMenu = "Menu 3"
                    }
                }
            } else {
                Text("iOS 15.0+\nmacOS 12.0+\nMac Catalyst 15.0+\ntvOS 15.0+\nwatchOS 8.0+")
            }
        }
    }
}

struct P110_ConfirmationDialog_Previews: PreviewProvider {
    static var previews: some View {
        P110_ConfirmationDialog()
    }
}
