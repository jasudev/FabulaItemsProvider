//
//  P252_EnvironmentalModifier.swift
//  
//
//  Created by jasu on 2022/05/20.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P252_EnvironmentalModifier: View {
    
    let concreteModifier = ConcreteModifier()
    
    public init() {}
    public var body: some View {
        VStack(spacing: 10) {
            Text("Light").modifier(concreteModifier)
                .environment(\.colorScheme, .light)
            Text("Dark").modifier(concreteModifier)
                .environment(\.colorScheme, .dark)
            Text("Light").modifier(concreteModifier)
                .environment(\.colorScheme, .light)
            Text("Dark").modifier(concreteModifier)
                .environment(\.colorScheme, .dark)
        }
    }
    
    struct BackgroundModifier: ViewModifier {
        let color: Color
        func body(content: Content) -> some View {
            content
                .padding()
                .background(color)
                .cornerRadius(8)
        }
    }
    
    struct ConcreteModifier: EnvironmentalModifier {
        func resolve(in environment: EnvironmentValues) -> BackgroundModifier {
            return BackgroundModifier(color: environment.colorScheme == .dark ? .fabulaPrimary : .fabulaSecondary)
        }
    }
}

struct P252_EnvironmentalModifier_Previews: PreviewProvider {
    static var previews: some View {
        P252_EnvironmentalModifier()
    }
}
