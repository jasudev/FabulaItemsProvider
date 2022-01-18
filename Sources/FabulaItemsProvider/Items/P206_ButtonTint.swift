//
//  P206_ButtonTint.swift
//  
//
//  Created by jasu on 2022/01/18.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P206_ButtonTint: View {
    
    @State private  var text: String = "-"
    
    public init() {}
    public var body: some View {
        VStack {
            Text(text)
                .bold()
                .font(.title)
            Divider()
            
            SectionGroupView(sectionTitle: "Button Tint") {
                if #available(macOS 12.0, *) {
                    Button("destructive", role: .destructive) {
                        text = "destructive"
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.purple)
                    
                    Button("cancel", role: .cancel) {
                        text = "cancel"
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.random)
                } else {
                    Text("@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)")
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

struct P206_ButtonTint_Previews: PreviewProvider {
    static var previews: some View {
        P206_ButtonTint()
    }
}
