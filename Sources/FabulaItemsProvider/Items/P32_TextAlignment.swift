//
//  P32_TextAlignment.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P32_TextAlignment: View {
    
    @State private var currentAlign = TextAlignment.leading
    let alignments: [TextAlignment] = [.leading, .center, .trailing]
    
    public init() {}
    public var body: some View {
        VStack {
            Text("Nulla vel consequat tellus. In lectus justo, semper fringilla tellus quis, ullamcorper porttitor ante. Phasellus ornare ultrices bibendum. Donec auctor eros neque, sit amet semper felis fringilla et. Morbi cursus, massa vitae euismod faucibus, velit sem fringilla ligula, eu consequat ante felis eleifend arcu. Aliquam ultricies mollis elit eu vehicula. Sed sed sapien eget ex maximus molestie. Integer venenatis ut enim eget laoreet.")
                .multilineTextAlignment(currentAlign)
            Divider().padding()
            Picker("Text Alignment", selection: $currentAlign.animation()) {
                ForEach(alignments, id: \.self) { align in
                    Text(String(describing: align))
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
        .frame(maxWidth: 500, maxHeight: 500)
    }
}

struct P32_TextAlignment_Previews: PreviewProvider {
    static var previews: some View {
        P32_TextAlignment().preferredColorScheme(.dark)
    }
}
