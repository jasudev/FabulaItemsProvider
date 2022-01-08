//
//  P59_DisclosureGroup.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P59_DisclosureGroup: View {
    
    private var spacerView: some View {
#if os(iOS)
        Spacer()
#else
        EmptyView()
#endif
    }
    
    @State private var expanded: Bool = false
    
    public init() {}
    public var body: some View {
        DisclosureGroup("Group", isExpanded: $expanded) {
            DisclosureGroup("1 Depth") {
                HStack {
                    Text("Item 1")
                    spacerView
                }
                HStack {
                    Text("Item 2")
                    spacerView
                }
                DisclosureGroup("2 Depth") {
                    HStack {
                        Text("Item 1")
                        spacerView
                    }
                    HStack {
                        Text("Item 2")
                        spacerView
                    }
                    HStack {
                        Text("Item 3")
                        spacerView
                    }
                }
                .foregroundColor(Color.blue)
                .padding(.leading, 20)
            }
            .foregroundColor(Color.green)
            .padding(.leading, 20)
        }
        .font(.custom("Helvetica SemiBold", size: 20))
        .foregroundColor(Color.red)
        .padding(.leading, 20)
        .frame(maxWidth: 500)
        .padding(.trailing, 20)
        .animation(.easeInOut, value: expanded)
    }
}

struct P59_DisclosureGroup_Previews: PreviewProvider {
    static var previews: some View {
        P59_DisclosureGroup()
    }
}
