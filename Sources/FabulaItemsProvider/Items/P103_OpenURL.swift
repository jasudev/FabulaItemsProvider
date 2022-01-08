//
//  P103_OpenURL.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P103_OpenURL: View {
    
    @Environment(\.openURL) var openURL
    
    public init() {}
    public var body: some View {
        Button(action: appUrlOpen) {
            Image(systemName: "link.circle")
            Text("Fabula App Url")
        }
    }
    
    func appUrlOpen() {
        guard let url = URL(string: "https://apps.apple.com/app/fabula-code-suite-for-swiftui/id1591155142") else {
            return
        }
        openURL(url)
    }
}

struct P103_OpenURL_Previews: PreviewProvider {
    static var previews: some View {
        P103_OpenURL()
    }
}
