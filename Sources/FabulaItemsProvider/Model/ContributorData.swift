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
    
    /// To provide a contributor's profile image, copy the image to Resources/Assets in the package and enter the image name in the imageName attribute.
    public let imageName: String?
    
    public var itemCount: Int {
        return ItemsProvider.shared.items.filter { item in
            item.creator == name
        }.count
    }
    
    public var image: Image? {
        if let imageName = imageName {
            return Image(imageName, bundle: .module)
        }
        return nil
    }
}
