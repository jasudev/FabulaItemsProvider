//
//  P196_TextPreferenceKey.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P196_TextPreferenceKey: View {
    
    @State private var text: String = ""
    
    public init() {}
    public var body: some View {
        VStack {
            Text("\(text)")
            Divider().frame(width: 44)
            Text("TextKey")
                .setText("Share text to the parent view")
        }
        .onPreferenceChange(TextKey.self) { text in
            self.text = text
        }
    }
}

fileprivate
struct TextKey: PreferenceKey {
    static var defaultValue: String = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

fileprivate
extension View {
    func setText(_ title: String) -> some View {
        self.preference(key: TextKey.self, value: title)
    }
}

struct P196_TextPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        P196_TextPreferenceKey()
    }
}
