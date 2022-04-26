//
//  P239_DynamicTextEditor.swift
//  
//
//  Created by jasu on 2022/04/26.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P239_DynamicTextEditor: View {
    
    @State private var text: String = ""
    @State var height : CGFloat = 20
    
    public init() {}
    public var body: some View {
        
        ZStack(alignment: .leading) {
            Text(text)
                .font(.callout)
                .padding(8)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self,
                                           value: $0.frame(in: .local).size.height)
                })
                .hidden()
            TextEditor(text: $text)
                .font(.callout)
                .frame(height: max(38,height))
                .padding(.horizontal, 3)
            
        }
        .background(Color.fabulaFore2.opacity(0.3))
        .cornerRadius(8)
        .onAppear {
#if os(iOS)
            UITextView.appearance().backgroundColor = .clear
#endif
        }
        .onDisappear {
#if os(iOS)
            UITextView.appearance().backgroundColor = nil
#endif
        }
        .onPreferenceChange(ViewHeightKey.self) { height = $0 }
        .padding()
    }
    
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct P239_DynamicTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        P239_DynamicTextEditor()
    }
}
