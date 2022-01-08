//
//  P77_Locale.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P77_Locale: View {
    
    public init() {}
    public var body: some View {
        VStack {
            LocaleView()
            Divider().frame(width: 40)
            LocaleView()
                .environment(\.locale, Locale(identifier: "ko"))
        }
    }
}

fileprivate
struct LocaleView: View {
    
    @Environment(\.locale) private var locale: Locale
    
    var body: some View {
        Text(locale.description)
    }
}

struct P77_Locale_Previews: PreviewProvider {
    static var previews: some View {
        P77_Locale()
    }
}
