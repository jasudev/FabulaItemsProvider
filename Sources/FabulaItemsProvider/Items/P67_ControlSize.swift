//
//  P67_ControlSize.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P67_ControlSize: View {
    
    @Environment(\.controlSize) private var controlSize: ControlSize
    
    public init() {}
    public var body: some View {
        ZStack {
            switch controlSize {
            case .mini : Text(".mini")
            case .small : Text(".small")
            case .regular : Text(".regular")
            case .large : Text(".large")
            default : EmptyView()
            }
        }
    }
}

struct P67_ControlSize_Previews: PreviewProvider {
    static var previews: some View {
        P67_ControlSize()
    }
}
