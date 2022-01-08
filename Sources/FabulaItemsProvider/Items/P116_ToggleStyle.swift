//
//  P116_ToggleStyle.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P116_ToggleStyle: View {
    
    @State private var isOn: Bool = false
    
    public init() {}
    public var body: some View {
        Toggle("Vertical Toggle", isOn: $isOn)
            .toggleStyle(VerticalToggleStyle())
            .fixedSize()
    }
}

fileprivate
struct VerticalToggleStyle: ToggleStyle {
    
    @Environment(\.colorScheme) private var colorScheme
    let idealSize: CGFloat = 36
    
    func makeBody(configuration: Configuration) -> some View {
        let isOn = configuration.isOn
        return HStack {
            configuration.label
            Spacer()
            
            GeometryReader { proxy in
                ZStack(alignment: isOn ? .top : .bottom) {
                    Capsule()
                        .fill(colorScheme == .dark ? Color.black.opacity(0.5) : Color.black.opacity(0.1))

                    Circle()
                        .fill(isOn ? Color.fabulaPrimary : getNormalColor().opacity(0.15))
                        .frame(width: proxy.size.width, height: proxy.size.width)
                        .padding(2)
                }
            }
            .frame(idealWidth: idealSize, idealHeight: idealSize * 2)
            .onTapGesture {
                withAnimation {
                    configuration.isOn.toggle()
                }
            }
        }
    }
    
    private func getNormalColor() -> Color {
        colorScheme == .dark ? Color.white : Color.black
    }
}

struct P116_ToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        P116_ToggleStyle()
    }
}
