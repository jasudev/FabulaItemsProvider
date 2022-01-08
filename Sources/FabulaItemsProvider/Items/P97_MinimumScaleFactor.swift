//
//  P97_MinimumScaleFactor.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P97_MinimumScaleFactor: View {
    
    @State private var text: String = "The minimum permissible proportion to shrink the font size to fit the text into the available space."
    
    public init() {}
    public var body: some View {
        VStack {
            MinimumScaleFactorView(text: $text)
                .environment(\.minimumScaleFactor, 0.5)
            Divider()
                .frame(width: 150)
                .padding()
            MinimumScaleFactorView(text: $text)
                .minimumScaleFactor(1)
            Divider()
                .frame(width: 250)
                .padding()
            TextEditor(text: $text)
                .frame(width: 250, height: 60, alignment: .center)
        }
        .padding()
    }
}

fileprivate
struct MinimumScaleFactorView: View {
    
    @Environment(\.minimumScaleFactor) private var minimumScaleFactor: CGFloat
    @Binding var text: String
    var body: some View {
        Text(text)
            .font(.body)
            .frame(width: 150, height: 50, alignment: .leading)
    }
}

struct P97_MinimumScaleFactor_Previews: PreviewProvider {
    static var previews: some View {
        P97_MinimumScaleFactor()
    }
}
