//
//  View+Extensions.swift
//  FabulaPlus
//
//  Created by jasu on 2022/01/01.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public extension View {
    
    func animationsDisabled() -> some View {
        return self.transaction { (tx: inout Transaction) in
            tx.disablesAnimations = true
            tx.animation = nil
        }
    }
#if os(iOS)
    func navigationBarColor(backgroundColor: Color?, titleColor: Color?) -> some View {
        let background: UIColor? = backgroundColor != nil ? UIColor(backgroundColor!) : nil
        let title: UIColor? = titleColor != nil ? UIColor(titleColor!) : nil
        return self.modifier(NavigationBarModifier(backgroundColor: background, titleColor: title))
    }
#endif
}
