//
//  P96_LineLimit.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P96_LineLimit: View {
    
    public init() {}
    public var body: some View {
        VStack {
            LineLimitView()
                .environment(\.lineLimit, 2)
            Divider()
                .frame(width: 150)
                .padding()
            LineLimitView()
                .lineLimit(1)
            Divider()
                .frame(width: 150)
                .padding()
            LineLimitView()
                .lineLimit(nil)
        }
        .padding()
    }
}

fileprivate
struct LineLimitView: View {
    
    @Environment(\.lineLimit) private var lineLimit: Int?
    
    var body: some View {
        Text("The maximum number of lines that text can occupy in a view.")
            .font(.body)
            .frame(width: 150, height: 50, alignment: .leading)
    }
}

struct P96_LineLimit_Previews: PreviewProvider {
    static var previews: some View {
        P96_LineLimit()
    }
}
