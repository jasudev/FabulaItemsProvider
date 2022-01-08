//
//  P39_ZStackAlignment.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P39_ZStackAlignment: View {
    
    let horizontalAlignments: [HorizontalAlignment] = [.leading, .center, .trailing]
    let verticalAlignments: [VerticalAlignment] = [.top, .center, .bottom]
    
    @State private var hIndex: Int = 1
    @State private var vIndex: Int = 1
    
    public init() {}
    public var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: horizontalAlignments[hIndex],
                                        vertical: verticalAlignments[vIndex])) {
                Color.clear
                Image(systemName: "umbrella")
                    .font(.largeTitle)
            }
            
            VStack {
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
            }
            .frame(maxWidth: 600)
        }
        .padding()
    }
}

struct P39_ZStackAlignment_Previews: PreviewProvider {
    static var previews: some View {
        P39_ZStackAlignment()
    }
}
