//
//  P49_ButtonStyleConfiguration.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P49_ButtonStyleConfiguration: View {
    
    public init() {}
    public var body: some View {
        Button("Press me!!!", action: action)
            .foregroundColor(Color.white)
            .buttonStyle(RoundedScaleButtonStyle())
    }
    
    private func action() {
        print("action")
    }
}

fileprivate
struct RoundedScaleButtonStyle: ButtonStyle {
    var background: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.fabulaPrimary)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(16)
            .background(
                background
                    .rotation3DEffect(Angle(degrees: configuration.isPressed ? 180 : 0), axis: (x: 1, y: 0, z: 0))
                    .animation(configuration.isPressed ? .none : .spring(), value: configuration.isPressed)
            )
    }
}

struct P49_ButtonStyleConfiguration_Previews: PreviewProvider {
    static var previews: some View {
        P49_ButtonStyleConfiguration()
    }
}
