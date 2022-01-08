//
//  P147_SceneStorage.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P147_SceneStorage: View {
    
    @SceneStorage("cityName") private var cityName = "Seoul"
    
    public init() {}
    public var body: some View {
        VStack {
            Text(cityName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.fabulaPrimary)
            Divider().frame(width: 44).padding()
            TextField(cityName, text: $cityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
        .frame(maxWidth: 500)
    }
}

struct P147_SceneStorage_Previews: PreviewProvider {
    static var previews: some View {
        P147_SceneStorage()
    }
}
