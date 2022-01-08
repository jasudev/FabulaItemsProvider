//
//  P105_ColorScheme.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P105_ColorScheme: View {
    
    public init() {}
    public var body: some View {
        VStack {
            ColorSchemeView()
            Divider()
                .frame(width: 44)
                .padding()
            ColorSchemeView()
                .environment(\.colorScheme, .light)
            Divider()
                .frame(width: 44)
                .padding()
            ColorSchemeView()
                .environment(\.colorScheme, .dark)
        }
    }
}

fileprivate
struct ColorSchemeView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        Text(colorScheme == .dark ? "Dark mode" : "Light mode")
    }
}

struct P105_ColorScheme_Previews: PreviewProvider {
    static var previews: some View {
        P105_ColorScheme()
    }
}
