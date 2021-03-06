//
//  P250_DynamicViewContent.swift
//  
//
//  Created by jasu on 2022/05/18.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P250_DynamicViewContent: View {
    
    @State private var items = ["Swipe1", "Swipe2", "Swipe3", "Swipe4", "Swipe5"]
    
    public init() {}
    public var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding()
            }
            .onDelete(perform: deleteItem)
            .onMove(perform: moveItem)
        }
#if os(iOS)
        .navigationBarTitle("Items")
        .navigationBarItems(trailing: EditButton())
#endif
    }
    
    func deleteItem(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
}

struct P250_DynamicViewContent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            P250_DynamicViewContent()
        }
    }
}
