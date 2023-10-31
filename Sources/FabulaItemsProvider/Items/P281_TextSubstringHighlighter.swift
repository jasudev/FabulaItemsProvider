//
//  P281_TextSubstringHighlighter.swift
//
//
//  Created by jasu on 2023/10/29.
//  Copyright (c) 2023 jasu All rights reserved.
//

import SwiftUI

public struct P281_TextSubstringHighlighter: View {
    
    @State private var text: String = "Some Attributed String"
    @State private var hilightText: String = "tr,ed,ing"
    
    var highlights: [String] {
        return hilightText.components(separatedBy: ",")
    }
    
    public init() {}
    public var body: some View {
        VStack {
            Text(text, highlights: highlights, color: .red, font: .system(size: 32, weight: .bold))
                .foregroundColor(.blue)
                .font(.system(size: 24, weight: .regular))
                .frame(height: 50)
            TextField("hilights", text: $hilightText)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
        .animation(.default, value: hilightText)
    }
}

fileprivate
extension Text {
    init(_ text: String, highlights: [String], color: Color, font: Font) {
        var attributedString = AttributedString(text)
        for highlight in highlights {
            var searchStartIndex = attributedString.startIndex
            while let range = attributedString[searchStartIndex...].range(of: highlight) {
                let startIndex = range.lowerBound
                let endIndex = range.upperBound
                attributedString[startIndex..<endIndex].foregroundColor = color
                attributedString[startIndex..<endIndex].font = font
                searchStartIndex = endIndex
            }
        }
        self.init(attributedString)
    }
}

struct P281_TextSubstringHighlighter_Previews: PreviewProvider {
    static var previews: some View {
        P281_TextSubstringHighlighter()
    }
}
