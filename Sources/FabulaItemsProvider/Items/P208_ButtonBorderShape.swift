//
//  P208_ButtonBorderShape.swift
//  
//
//  Created by jasu on 2022/01/18.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P208_ButtonBorderShape: View {
    
    @State private  var text: String = "-"
    
    public init() {}
    public var body: some View {
#if os(iOS)
        VStack {
            Text(text)
                .bold()
                .font(.title)
            Divider()
            
            SectionGroupView(sectionTitle: "Button Border Shape") {
                Button("capsule", role: .destructive) {
                    text = "capsule"
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.capsule)
                
                Button("roundedRectangle", role: .destructive) {
                    text = "roundedRectangle"
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle)
                
                Button("roundedRectangle(radius: 16)", role: .destructive) {
                    text = "roundedRectangle(radius: 16)"
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle(radius: 16))
            }
            .padding()
        }
        .frame(maxWidth: 500)
        .padding()
#else
        EmptyView()
#endif
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

struct P208_ButtonBorderShape_Previews: PreviewProvider {
    static var previews: some View {
        P208_ButtonBorderShape()
    }
}
