//
//  P98_TextCase.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P98_TextCase: View {
    
    public init() {}
    public var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("original")
                    .font(.callout)
                    .opacity(0.5)
                TextCaseView()
            }
            Divider()
                .frame(width: 200)
                .padding()
            VStack(alignment: .leading) {
                Text("lowercase")
                    .font(.callout)
                    .opacity(0.5)
                TextCaseView()
                    .environment(\.textCase, .lowercase)
            }
            Divider()
                .frame(width: 200)
                .padding()
            VStack(alignment: .leading) {
                Text("uppercase")
                    .font(.callout)
                    .opacity(0.5)
                TextCaseView()
                    .textCase(.uppercase)
            }
        }
        .padding()
    }
}

fileprivate
struct TextCaseView: View {
    
    @Environment(\.textCase) private var textCase: Text.Case?
    
    var body: some View {
        Text("A stylistic override to transform the case of Text when displayed, using the environment’s locale.")
            .font(.body)
            .frame(width: 200, height: 50, alignment: .leading)
    }
}

struct P98_TextCase_Previews: PreviewProvider {
    static var previews: some View {
        P98_TextCase()
    }
}
