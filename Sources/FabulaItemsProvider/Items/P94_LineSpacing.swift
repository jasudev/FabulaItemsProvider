//
//  P94_LineSpacing.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P94_LineSpacing: View {
    
    public init() {}
    public var body: some View {
        VStack {
            LineSpacingView()
                .environment(\.lineSpacing, 10)
            Divider()
                .frame(width: 160)
                .padding()
            LineSpacingView()
                .lineSpacing(1)
        }
        .padding()
    }
}

fileprivate
struct LineSpacingView: View {
    
    @Environment(\.lineSpacing) private var lineSpacing: CGFloat
    
    var body: some View {
        Text("The distance in points between the bottom of one line fragment and the top of the next.")
            .frame(width: 160, alignment: .leading)
    }
}

struct P94_LineSpacing_Previews: PreviewProvider {
    static var previews: some View {
        P94_LineSpacing()
    }
}
