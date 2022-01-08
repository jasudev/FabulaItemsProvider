//
//  P155_Spacer.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P155_Spacer: View {
    
    enum SpacerAlignment {
        case left
        case right
    }
    
    @State private var alignment: SpacerAlignment = .left
    
    public init() {}
    public var body: some View {
        VStack {
            HStack {
                if alignment == .right {
                    Spacer()
                }
                ChecklistRow(name: "Margin")
                if alignment == .left {
                    Spacer()
                }
            }
            .padding()
            .border(Color.fabulaPrimary)
            
            Divider().padding()
            
            Picker("Margin", selection: $alignment) {
                Text("Left").tag(SpacerAlignment.left)
                Text("Right").tag(SpacerAlignment.right)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .animation(.easeInOut, value: alignment)
        .padding()
        .frame(maxWidth: 500)
    }
}

fileprivate
extension P155_Spacer {
    struct ChecklistRow: View {
        
        let name: String
        
        var body: some View {
            HStack {
                Image(systemName: "checkmark")
                Text(name)
            }
        }
    }
}


struct P155_Spacer_Previews: PreviewProvider {
    static var previews: some View {
        P155_Spacer()
    }
}
