//
//  P35_Label.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P35_Label: View {
    
    let types: [LabelStyleType] = [.titleAndIcon, .titleOnly, .iconOnly]
    @State private var currentType: LabelStyleType = .titleAndIcon
    
    public init() {}
    public var body: some View {
        VStack {
            ZStack {
                switch currentType {
                case .titleAndIcon:
                    Label("Person", systemImage: "person.crop.circle")
                        .font(.title)
                        .labelStyle(DefaultLabelStyle())
                case .titleOnly:
                    Label("Person", systemImage: "person.crop.circle")
                        .font(.title)
                        .labelStyle(TitleOnlyLabelStyle())
                case .iconOnly:
                    Label("Person", systemImage: "person.crop.circle")
                        .font(.title)
                        .labelStyle(IconOnlyLabelStyle())
                }
            }
            .frame(height: 50)
            Divider().padding()
            Picker("Label Style", selection: $currentType) {
                ForEach(types, id: \.self) { type in
                    Text(String(describing: type))
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
        .frame(maxWidth: 500, maxHeight: 500)
    }
}

extension P35_Label {
    enum LabelStyleType {
        case titleAndIcon
        case titleOnly
        case iconOnly
    }
}

struct P35_Label_Previews: PreviewProvider {
    static var previews: some View {
        P35_Label()
    }
}
