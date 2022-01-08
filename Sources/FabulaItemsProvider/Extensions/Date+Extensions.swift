//
//  Date+Extensions.swift
//  Fabula
//
//  Created by jasu on 2022/01/05.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public extension Date {
    func dateToString(style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}
