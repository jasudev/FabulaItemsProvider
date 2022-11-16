//
//  Contributor.swift
//  
//
//  Created by jasu on 2022/09/16.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

/// Contributors who added items can add contributor information here.
/// To provide a contributor's profile image, copy the image to Resources/Assets in the package and enter the image name in the imageName attribute.
public struct Contributor {
    
    public static let list = [
        Contributor.jasu,
        Contributor.soccer01,
    ]
    
    public static let jasu = ContributorData(name: "jasu", location: "Korea", email: "jasudev@gmail.com", link: "https://github.com/jasudev", imageName: "jasu")
    public static let soccer01 = ContributorData(name: "soccer01", location: "Korea", email: "cudo0159@gmail.com", link: nil, imageName: nil)
}
