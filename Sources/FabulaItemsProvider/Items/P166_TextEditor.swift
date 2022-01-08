//
//  P166_TextEditor.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P166_TextEditor: View {
    
    @State private var text = ""
    @State private var wordCount: Int = 0
    
    public init() {}
    public var body: some View {
        VStack(alignment: .trailing) {
            if wordCount > 0 {
                Text("\(wordCount) words")
                    .font(.headline)
                    .foregroundColor(wordCount == 0 ? Color.secondary : Color.fabulaPrimary)
                    .transition(.scale.combined(with: .opacity))
            }
            TextEditor(text: $text)
                .font(.body)
                .padding()
                .background(Color.black.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .onChange(of: text) { value in
                    let words = text.split { $0 == " " || $0.isNewline }
                    self.wordCount = words.count
                }
#if os(iOS)
                .onAppear {
                    UITextView.appearance().backgroundColor = UIColor.clear
                }
#endif
        }
        .animation(.easeInOut, value: wordCount)
        .padding()
        .frame(maxWidth: 500, maxHeight: 500)
    }
}

struct P166_TextEditor_Previews: PreviewProvider {
    static var previews: some View {
        P166_TextEditor()
    }
}
