//
//  P68_ControlActiveState.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P68_ControlActiveState: View {
#if os(macOS)
    @Environment(\.controlActiveState) private var controlActiveState: ControlActiveState
    
    public init() {}
    public var body: some View {
        switch controlActiveState {
        case .key : Text("key")
        case .active : Text("active")
        case .inactive : Text("inactive")
        default: EmptyView()
        }
    }
#else
    public init() {}
    public var body: some View {
        EmptyView()
    }
#endif
}

struct P68_ControlActiveState_Previews: PreviewProvider {
    static var previews: some View {
        P68_ControlActiveState()
    }
}
