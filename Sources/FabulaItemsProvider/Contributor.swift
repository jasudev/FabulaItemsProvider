//
//  Contributor.swift
//  
//
//  Created by jasu on 2022/09/16.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct Contributor {
    
    public static let list = [
        Contributor.jasu,
        Contributor.soccer01,
    ]
    
    public static let jasu = ContributorData(name: "jasu", location: "Korea", email: "jasudev@gmail.com", link: "https://github.com/jasudev", imageName: "jasu")
    public static let soccer01 = ContributorData(name: "soccer01", location: "Korea", email: nil, link: nil, imageName: nil)
}
