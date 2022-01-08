//
//  P81_DefaultMinListHeaderHeight.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P81_DefaultMinListHeaderHeight: View {
    
    public init() {}
    public var body: some View {
        HStack {
            VStack {
                Text("Default")
                    .font(.callout)
                    .opacity(0.5)
                DefaultMinListHeaderHeightView()
            }
            Divider()
            VStack {
                Text("Custom height : 100")
                    .font(.callout)
                    .opacity(0.5)
                DefaultMinListHeaderHeightView()
                    .environment(\.defaultMinListHeaderHeight, 100)
            }
        }
        .padding()
    }
}

fileprivate
struct DefaultMinListHeaderHeightView: View {
    
    @Environment(\.defaultMinListHeaderHeight) private var defaultMinListHeaderHeight: CGFloat?
    
    var body: some View {
        List(0...100, id: \.self) { index in
            Section {
                Text("Index : \(index)")
                    .opacity(0.5)
            } header: {
                Text("Section Index : \(index)")
                    .foregroundColor(Color.fabulaPrimary)
            }
        }
    }
}

struct P81_DefaultMinListHeaderHeight_Previews: PreviewProvider {
    static var previews: some View {
        P81_DefaultMinListHeaderHeight()
    }
}
