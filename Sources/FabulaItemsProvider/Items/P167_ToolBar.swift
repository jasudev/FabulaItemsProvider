//
//  P167_ToolBar.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P167_ToolBar: View {
    
    public init() {}
    public var body: some View {
        Text("Hello, World!").padding()
            .navigationTitle("SwiftUI")
#if os(iOS)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("First Navigation") {
                        print("Pressed")
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("First Bottom") {
                        print("Pressed")
                    }
                    Spacer()
                    Button("Second Bottom") {
                        print("Pressed")
                    }
                }
            }
#else
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Automatic") {
                        print("Pressed")
                    }
                }
//                ToolbarItemGroup(placement: .status) {
//                    Button("Status") {
//                        print("Pressed")
//                    }
//                }
//                ToolbarItemGroup(placement: .cancellationAction) {
//                    Button("CancellationAction") {
//                        print("Pressed")
//                    }
//                }
//                ToolbarItemGroup(placement: .destructiveAction) {
//                    Button("DestructiveAction") {
//                        print("Pressed")
//                    }
//                }
//                ToolbarItemGroup(placement: .primaryAction) {
//                    Button("PrimaryAction") {
//                        print("Pressed")
//                    }
//                }
            }
#endif
    }
}

struct P167_ToolBar_Previews: PreviewProvider {
    static var previews: some View {
        P167_ToolBar()
    }
}
