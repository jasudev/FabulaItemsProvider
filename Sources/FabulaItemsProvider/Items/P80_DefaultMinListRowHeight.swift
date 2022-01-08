//
//  P80_DefaultMinListRowHeight.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P80_DefaultMinListRowHeight: View {
    
    public init() {}
    public var body: some View {
        HStack {
            VStack {
                Text("Default")
                    .font(.callout)
                    .opacity(0.5)
                DefaultMinListRowHeightView()
            }
            Divider()
            VStack {
                Text("Custom height : 100")
                    .font(.callout)
                    .opacity(0.5)
                DefaultMinListRowHeightView()
                    .environment(\.defaultMinListRowHeight, 100)
            }
        }
        .padding()
    }
}

fileprivate
struct DefaultMinListRowHeightView: View {
    
    @Environment(\.defaultMinListRowHeight) private var defaultMinListRowHeight: CGFloat
    
    var body: some View {
        List(0...100, id: \.self) { index in
            Text("Index : \(index)")
        }
    }
}

struct P80_DefaultMinListRowHeight_Previews: PreviewProvider {
    static var previews: some View {
        P80_DefaultMinListRowHeight()
    }
}
