//
//  P40_VStackAlignment.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P40_VStackAlignment: View {
    
    let horizontalAlignments: [HorizontalAlignment] = [.leading, .center, .trailing]
    @State private var hIndex: Int = 1
    
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            VStack(alignment: horizontalAlignments[hIndex]) {
                Color.clear.frame(height: 1)
                Image(systemName: "sun.max")
                    .font(.largeTitle)
                Image(systemName: "cloud.heavyrain")
                    .font(.largeTitle)
                Image(systemName: "umbrella")
                    .font(.largeTitle)
            }
            
            Spacer()
            Picker("Horizontal", selection: $hIndex.animation()) {
                ForEach(0...2, id: \.self) { index in
                    switch index {
                    case 0: Text("leading")
                    case 1: Text("center")
                    case 2: Text("trailing")
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

struct P40_VStackAlignment_Previews: PreviewProvider {
    static var previews: some View {
        P40_VStackAlignment()
    }
}
