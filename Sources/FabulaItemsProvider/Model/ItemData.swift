//
//  ItemData.swift
//  Fabula
//
//  Created by jasu on 2021/08/30.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public enum PlatformType {
    case iOS
    case macOS
    case both
}

public enum CategoryType: String, Hashable {
    case uiux = "shippingbox"
    case play = "cube.transparent"
    case study = "square.3.stack.3d"
}

public struct ItemData: Identifiable {
    
    public private(set) var id: Int32
    public private(set) var category: CategoryType
    public private(set) var section: String
    public private(set) var createDate: String
    public private(set) var title: String
    public private(set) var caption: String
    public private(set) var creator: String
    public private(set) var tags: String
    public private(set) var view: FAnyView
    public private(set) var platformType: PlatformType = .both

    public var navigationTitle: String {
        return "[\(self.section)]" + " - " + self.title + " - " + self.caption
    }
    
    public var itemTitle: String {
        return "item\(self.id)"
    }

    public var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name:"UTC") as TimeZone?
        let date = dateFormatter.date(from: createDate)
        return date!
    }
    
    public init(id: Int32, category: CategoryType, section: String, createDate: String, title: String, caption: String, creator: String, tags: String, view: FAnyView, platformType: PlatformType = .both) {
        self.id = id
        self.category = category
        self.section = section
        self.createDate = createDate
        self.title = title
        self.caption = caption
        self.creator = creator
        self.tags = tags
        self.view = view
        self.platformType = platformType
    }
}

extension Date {
    var day: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        let dayOfMonth = components.day
        return "\(String(format:"%02d", dayOfMonth!))"
    }
    
    var week: String {
        let weekTitles = ["일", "월", "화", "수", "목", "금", "토"]
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        let dayOfWeek = components.weekday
        return weekTitles[dayOfWeek! - 1]
    }
}
