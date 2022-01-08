//
//  P43_TimelineView.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P43_TimelineView: View {
    
    public init() {}
    public var body: some View {
#if os(iOS)
        TimelineView(.periodic(from: .now, by: 1.0 * 0.01)) { context in
            VStack {
                Text(String(format: "%.2f", context.date.timeIntervalSince1970))
                    .font(.custom("Helvetica Bold", fixedSize: 30))
                    .foregroundColor(Color.fabulaPrimary)
                Text(String(describing: context.date))
                    .font(.subheadline)
            }
        }
#else
        EmptyView()
#endif
    }
}

struct P43_TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        P43_TimelineView()
    }
}
