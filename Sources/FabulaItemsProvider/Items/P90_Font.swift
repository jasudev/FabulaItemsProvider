//
//  P90_Font.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P90_Font: View {
    
    public init() {}
    public var body: some View {
        VStack {
            FontView()
                .environment(\.font, .system(
                    size: 24,
                    weight: .ultraLight,
                    design: .rounded))
            Divider()
                .frame(width: 44)
                .padding()
            FontView()
                .font(.custom("Georgia", size: 24, relativeTo: .headline))
        }
        
    }
}

fileprivate
struct FontView: View {
    
    @Environment(\.font) private var font: Font?
    
    var body: some View {
        HStack {
            Text("Font")
                .font(font?.uppercaseSmallCaps())
            Text("Font")
                .font(font?.lowercaseSmallCaps())
            Text("Font")
                .font(font?.smallCaps())
        }
    }
}

struct P90_Font_Previews: PreviewProvider {
    static var previews: some View {
        P90_Font()
    }
}
