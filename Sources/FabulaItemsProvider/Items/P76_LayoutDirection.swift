//
//  P76_LayoutDirection.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P76_LayoutDirection: View {
    
    @Environment(\.layoutDirection) private var layoutDirection: LayoutDirection
    
    public init() {}
    public var body: some View {
        VStack {
            OtherLocaleView()
                .foregroundColor(Color.fabulaPrimary)
                .environment(\.locale, Locale(identifier: "ar"))
                .environment(\.layoutDirection, .rightToLeft)
            Divider()
                .frame(width: 44)
                .padding()
            OtherLocaleView()
        }
    }
}

fileprivate
struct OtherLocaleView: View {
    
    @Environment(\.layoutDirection) private var layoutDirection: LayoutDirection
    
    var body: some View {
        switch layoutDirection {
        case .leftToRight:
            Text("leftToRight")
        case .rightToLeft:
            Text("rightToLeft")
        default:
            EmptyView()
        }
    }
}

struct P76_LayoutDirection_Previews: PreviewProvider {
    static var previews: some View {
        P76_LayoutDirection()
    }
}
