//
//  P109_CustomStack.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P109_CustomStack: View {
    
    public init() {}
    public var body: some View {
        CustomVStack {
            Text("CustomVStack!")
            Text("CustomVStack!")
            CustomHStack {
                Text("CustomHStack!")
                    .frame(height: 70)
                Text("CustomHStack!")
            }
        }
    }
}

fileprivate
struct CustomVStack<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            content
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
        }
    }
}

fileprivate
struct CustomHStack<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            content
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .foregroundColor(Color.white)
        }
    }
}

struct P109_CustomStack_Previews: PreviewProvider {
    static var previews: some View {
        P109_CustomStack()
    }
}
