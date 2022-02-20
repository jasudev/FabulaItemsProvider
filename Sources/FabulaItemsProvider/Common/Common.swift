//
//  Common.swift
//  Fabula
//
//  Created by jasu on 2021/08/30.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI
import AxisSheet

public let FABULA_APP_URL: String = "https://apps.apple.com/app/id1591155142"
public let FABULA_APP_INSTAGRAM_URL = "https://www.instagram.com/dev.fabula"
public let FABULA_GITHUB_URL = "https://github.com/jasudev/FabulaItemsProvider"

public var isPad: Bool {
#if os(iOS)
    return UIDevice.current.userInterfaceIdiom != .phone
#else
    return false
#endif
}

#if os(iOS)
public func vibration(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
    let feedback = UIImpactFeedbackGenerator(style: style)
    feedback.prepare()
    feedback.impactOccurred()
}
#else
public func vibration() {}
#endif

public extension View {
    func adaptiveAxisSheet(isPresented: Binding<Bool>, bottomSize: CGFloat = 110, trailingSize: CGFloat = 260) -> some View {
        GeometryReader { proxy in
            if proxy.size.width < proxy.size.height {
                let constants = ASConstant(axisMode: .bottom, size: bottomSize,
                                           header: ASHeaderConstant(backgroundColor: .fabulaBack0.opacity(0.9)),
                                           background: ASBackgroundConstant(disabled: true))
                AxisSheet(isPresented: isPresented, constants: constants) {
                    VStack {
                        self
                        Spacer()
                    }
                    .background(Color.fabulaBack2.opacity(0.8))
                }
            }else {
                let constants = ASConstant(axisMode: .trailing, size: trailingSize,
                                           header: ASHeaderConstant(backgroundColor: .fabulaBack0.opacity(0.9)),
                                           background: ASBackgroundConstant(disabled: true))
                AxisSheet(isPresented: isPresented, constants: constants) {
                    VStack {
                        self
                        Spacer()
                    }
                    .background(Color.fabulaBack2.opacity(0.8))
                }
            }
        }
    }
}
