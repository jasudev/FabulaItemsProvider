//
//  P34_TextSpacing.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P34_TextSpacing: View {
    
    @State private var spacing: Double = 1
    @State private var isOpen: Bool = false
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack(alignment: .leading) {
                Text(".kerning")
                    .font(.caption)
                Text("raffle")
                    .font(.custom("AmericanTypewriter", size: 24))
                    .kerning(spacing)
                    .opacity(0.5)
            }
            Divider()
            VStack(alignment: .leading) {
                Text(".tracking")
                    .font(.caption)
                Text("raffle")
                    .font(.custom("AmericanTypewriter", size: 24))
                    .tracking(spacing)
                    .opacity(0.5)
            }
            Slider(value: $spacing, in: 1...100) {
                Text("Spacing").modifier(FabulaSectionModifier())
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: 500)
        .animation(Animation.easeOut(duration: 0.1), value: spacing)
    }
}

fileprivate
struct FabulaSectionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(Color.fabulaFore1.opacity(0.5))
            .frame(height: 32)
    }
}

struct P34_TextSpacing_Previews: PreviewProvider {
    static var previews: some View {
        P34_TextSpacing()
    }
}
