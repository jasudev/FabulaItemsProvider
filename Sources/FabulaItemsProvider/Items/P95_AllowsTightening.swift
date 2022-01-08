//
//  P95_AllowsTightening.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P95_AllowsTightening: View {
    
    public init() {}
    public var body: some View {
        VStack {
            AllowsTighteningView()
                .lineLimit(1)
                .environment(\.allowsTightening, true)
            Divider()
                .frame(width: 150)
                .padding()
            AllowsTighteningView()
                .lineLimit(1)
                .allowsTightening(false)
        }
        .padding()
    }
}

fileprivate
struct AllowsTighteningView: View {
    
    @Environment(\.allowsTightening) private var allowsTightening: Bool
    
    var body: some View {
        Text("This is a wide text element")
            .font(.body)
#if os(iOS)
            .frame(width: 200, height: 50, alignment: .leading)
#else
            .frame(width: 150, height: 50, alignment: .leading)
#endif
    }
}

struct P95_AllowsTightening_Previews: PreviewProvider {
    static var previews: some View {
        P95_AllowsTightening()
    }
}
