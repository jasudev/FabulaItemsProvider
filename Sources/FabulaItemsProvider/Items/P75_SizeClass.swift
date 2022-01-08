//
//  P75_SizeClass.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P75_SizeClass: View {
    
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?
    
    public init() {}
    public var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .center, spacing: 3) {
                Text("horizontalSizeClass")
                    .font(.caption)
                    .opacity(0.5)
                if horizontalSizeClass == .compact {
                    Text("Compact").foregroundColor(Color.fabulaPrimary)
                } else {
                    Text("Regular")
                }
            }
            VStack(alignment: .center, spacing: 3) {
                Text("verticalSizeClass")
                    .font(.caption)
                    .opacity(0.5)
                if verticalSizeClass == .compact {
                    Text("Compact").foregroundColor(Color.fabulaPrimary)
                } else {
                    Text("Regular")
                }
            }
        }
    }
#else
    public init() {}
    public var body: some View {
        EmptyView()
    }
#endif
}

struct P75_SizeClass_Previews: PreviewProvider {
    static var previews: some View {
        P75_SizeClass()
    }
}
