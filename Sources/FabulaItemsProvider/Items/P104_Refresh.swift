//
//  P104_Refresh.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P104_Refresh: View {
    
    @State private var posts = [PostItem(id: 0, title: "Item 0")]
    
    public init() {}
    public var body: some View {
        List(posts) { item in
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
            }
        }
#if os(iOS)
        .listStyle(GroupedListStyle())
        .refreshable {
            var newPosts = [PostItem]()
            for index in 0...3 {
                let index = posts.count + index
                newPosts.append(PostItem(id: index, title: "Item \(index)"))
            }
            posts += newPosts
        }
#endif
    }
}

fileprivate
struct PostItem: Decodable, Identifiable {
    let id: Int
    let title: String
}

struct P104_Refresh_Previews: PreviewProvider {
    static var previews: some View {
        P104_Refresh()
    }
}
