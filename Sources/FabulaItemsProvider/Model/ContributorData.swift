//
//  ContributorData.swift
//  
//
//  Created by jasu on 2022/09/16.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct ContributorData {
    public let name: String
    public let location: String?
    public let email: String?
    public let link: String?
    public let imageName: String?
    
    var itemCount: Int {
        return ItemsProvider.shared.items.filter { item in
            item.creator == name
        }.count
    }
}
