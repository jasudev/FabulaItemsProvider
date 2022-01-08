//
//  P170_ViewBuilder.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P170_ViewBuilder: View {
    
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            HStack(content: contentViews)
            Divider()
                .frame(width: 44)
                .padding()
            BuilderGroup {
                Text("First Text - BuilderGroup").tag(0)
                Text("Second Text - BuilderGroup").tag(1)
            }
        }
    }
    
    @ViewBuilder
    func contentViews() -> some View {
        Text("First Text")
        Text("|")
        Text("Second Text")
    }
}

fileprivate
extension P170_ViewBuilder {
    struct BuilderGroup<Content>: View where Content: View {
        var views: Content
        @State private var index: Int = 0
        init(@ViewBuilder content: () -> Content) {
            self.views = content()
        }
        
        var body: some View {
            VStack {
                Text("Selected Index: \(index)")
                TabView(selection: $index) {
                    views
                        .padding()
                        .background(Color.fabulaPrimary)
                }
#if os(iOS)
                .tabViewStyle(PageTabViewStyle())
#endif
            }
            .frame(maxWidth: 500)
        }
    }
}
struct P170_ViewBuilder_Previews: PreviewProvider {
    static var previews: some View {
        P170_ViewBuilder()
    }
}
