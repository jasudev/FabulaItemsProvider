//
//  P250_DynamicViewContent.swift
//  
//
//  Created by jasu on 2022/05/18.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P250_DynamicViewContent: View {
    
    @State private var items = ["Item1", "Item2", "Item3", "Item4", "Item5"]
    
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
        .navigationBarTitle("Items")
        .navigationBarItems(trailing: EditButton())
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
