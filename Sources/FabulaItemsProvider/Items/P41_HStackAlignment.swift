//
//  P41_HStackAlignment.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P41_HStackAlignment: View {
    
    let verticalAlignments: [VerticalAlignment] = [.top, .center, .bottom]
    @State private var vIndex: Int = 1
    
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            HStack(alignment: verticalAlignments[vIndex]) {
                Color.clear.frame(width: 1)
                Image(systemName: "sun.max")
                    .font(.largeTitle)
                Image(systemName: "cloud.heavyrain")
                    .font(.largeTitle)
                Image(systemName: "umbrella")
                    .font(.largeTitle)
            }
            
            Spacer()
            Picker("Vertical", selection: $vIndex.animation()) {
                ForEach(0...2, id: \.self) { index in
                    switch index {
                    case 0: Text("top")
                    case 1: Text("center")
                    case 2: Text("bottom")
                    default:
                        EmptyView()
                    }
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(maxWidth: 600)
        }
        .padding()
    }
}

struct P41_HStackAlignment_Previews: PreviewProvider {
    static var previews: some View {
        P41_HStackAlignment()
    }
}
