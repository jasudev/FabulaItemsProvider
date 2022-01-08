//
//  NavigationBarModifier.swift
//  FabulaPlus
//
//  Created by jasu on 2022/01/01.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.shadowImage = UIImage()
        coloredAppearance.backgroundColor = .clear

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
