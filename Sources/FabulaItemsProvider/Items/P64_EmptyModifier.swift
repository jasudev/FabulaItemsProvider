//
//  P64_EmptyModifier.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P64_EmptyModifier: View {

    var modifier: some ViewModifier {
#if !DEBUG
        return CapsuleLayout()
#else
        return EmptyModifier()
#endif
    }
    
    public init() {}
    public var body: some View {
        Text("Hello, World!")
            .modifier(modifier)
    }
}

fileprivate
struct CapsuleLayout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.black)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
    }
}

struct P64_EmptyModifier_Previews: PreviewProvider {
    static var previews: some View {
        P64_EmptyModifier()
    }
}
