//
//  P205_ButtonStyle.swift
//  
//
//  Created by jasu on 2022/01/18.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P205_ButtonStyle: View {
    
    @State private  var text: String = "-"
    
    public init() {}
    public var body: some View {
        VStack {
            Text(text)
                .bold()
                .font(.title)
            Divider()
            
            SectionGroupView(sectionTitle: "Button Style") {
                Button("bordered") {
                    text = "bordered"
                }
                .buttonStyle(.bordered)
                
                Button("borderless") {
                    text = "borderless"
                }
                .buttonStyle(.borderless)
                
                if #available(macOS 12.0, *) {
                    Button("borderedProminent") {
                        text = "borderedProminent"
                    }
                    .buttonStyle(.borderedProminent)
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

struct P205_ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        P205_ButtonStyle()
    }
}
