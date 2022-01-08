//
//  P178_CustomViewModifier.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P178_CustomViewModifier: View {
    
    public init() {}
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .redText(font: .largeTitle)
    }
}

fileprivate
struct RedTextModifier: ViewModifier {
    
    let font: Font
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .padding()
            .foregroundColor(Color.red)
            .cornerRadius(6.0)
    }
}

fileprivate
extension View {
    func redText(font: Font = .callout) -> some View {
        modifier(RedTextModifier(font: font))
    }
}

struct P178_CustomViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        P178_CustomViewModifier()
    }
}
