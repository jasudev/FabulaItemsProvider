//
//  P93_TruncationMode.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P93_TruncationMode: View {
    
    public init() {}
    public var body: some View {
        VStack {
            TruncationModeView()
                .environment(\.truncationMode, .head)
            Divider()
                .frame(width: 200)
                .padding()
            TruncationModeView()
                .truncationMode(.middle)
            Divider()
                .frame(width: 200)
                .padding()
            TruncationModeView()
                .truncationMode(.tail)
        }
        .padding()
    }
}

fileprivate
struct TruncationModeView: View {
    
    @Environment(\.multilineTextAlignment) private var multilineTextAlignment: TextAlignment
    
    var body: some View {
        Text("A value that indicates how the layout truncates the last line of text to fit into the available space.")
            .frame(width: 200, height: 20, alignment: .leading)
    }
}

struct P93_TruncationMode_Previews: PreviewProvider {
    static var previews: some View {
        P93_TruncationMode()
    }
}
