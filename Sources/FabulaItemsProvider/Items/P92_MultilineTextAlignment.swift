//
//  P92_MultilineTextAlignment.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P92_MultilineTextAlignment: View {
    
    public init() {}
    public var body: some View {
        VStack {
            MultilineTextAllignmentView()
                .environment(\.multilineTextAlignment, .trailing)
            Divider()
                .frame(width: 200)
                .padding()
            MultilineTextAllignmentView()
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
}

fileprivate
struct MultilineTextAllignmentView: View {
    
    @Environment(\.multilineTextAlignment) private var multilineTextAlignment: TextAlignment
    
    var body: some View {
        Text("This is a block of text that will show up in a text element as multiple lines.\("\n") Here we have chosen to center this text.")
            .frame(width: 200, height: 160, alignment: .leading)
    }
}

struct P92_MultilineTextAlignment_Previews: PreviewProvider {
    static var previews: some View {
        P92_MultilineTextAlignment()
    }
}
