//
//  Common.swift
//  Fabula
//
//  Created by jasu on 2021/08/30.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

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
    #if os(iOS)
    let feedback = UIImpactFeedbackGenerator(style: style)
    feedback.prepare()
    feedback.impactOccurred()
    #endif
}
#else
public func vibration() {}
#endif
