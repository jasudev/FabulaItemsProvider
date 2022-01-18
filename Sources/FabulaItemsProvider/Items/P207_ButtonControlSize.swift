//
//  P207_ButtonControlSize.swift
//  
//
//  Created by jasu on 2022/01/18.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P207_ButtonControlSize: View {
    
    @State private  var text: String = "-"
    
    public init() {}
    public var body: some View {
        VStack {
            Text(text)
                .bold()
                .font(.title)
            Divider()
            
            SectionGroupView(sectionTitle: "Button Control Size") {
                if #available(macOS 12.0, *) {
                    Button("large", role: .cancel) {
                        text = "large"
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    
                    Button("regular", role: .cancel) {
                        text = "regular"
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.regular)
                    
                    Button("small", role: .cancel) {
                        text = "small"
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                    
                    Button("mini", role: .cancel) {
                        text = "mini"
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.mini)
                }else {
                    Button("large") {
                        text = "large"
                    }
                    .controlSize(.large)
                    
                    Button("regular") {
                        text = "regular"
                    }
                    .controlSize(.regular)
                    
                    Button("small") {
                        text = "small"
                    }
                    .controlSize(.small)
                    
                    Button("mini") {
                        text = "mini"
                    }
                    .controlSize(.mini)
                }
            }
            .padding()
        }
        .frame(maxWidth: 500)
        .padding()
    }
}

fileprivate
struct SectionGroupView<Content>: View where Content: View {
    
    var sectionTitle: String
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack {
            Text(sectionTitle)
                .foregroundColor(Color.fabulaFore2)
                .font(.caption)
            
            Divider().frame(width: 44)
            content()
        }
    }
}

struct P207_ButtonControlSize_Previews: PreviewProvider {
    static var previews: some View {
        P207_ButtonControlSize()
    }
}
