//
//  FabulaPlusApp.swift
//  FabulaPlus
//
//  Created by jasu on 2022/01/03.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

@main
struct FabulaPlusApp: App {
    var body: some Scene {
        WindowGroup {
#if os(iOS)
            ContentView_iOS()
#else
            ContentView_macOS()
#endif
        }
    }
}
