//
//  P134_List.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P134_List: View {
    
    struct Ocean: Identifiable {
        let name: String
        let id = UUID()
    }
    
    private var oceans = [
        Ocean(name: "Pacific"),
        Ocean(name: "Atlantic"),
        Ocean(name: "Indian"),
        Ocean(name: "Southern"),
        Ocean(name: "Arctic")
    ]
    
    struct FileItem: Hashable, Identifiable, CustomStringConvertible {
        var id: Self { self }
        var name: String
        var children: [FileItem]? = nil
        var description: String {
            switch children {
            case nil:
                return "📄 \(name)"
            case .some(let children):
                return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
            }
        }
    }
    let fileHierarchyData: [FileItem] = [
        FileItem(name: "users", children:
                    [FileItem(name: "user1234", children:
                                [FileItem(name: "Photos", children:
                                            [FileItem(name: "photo001.jpg"),
                                             FileItem(name: "photo002.jpg")]),
                                 FileItem(name: "Movies", children:
                                            [FileItem(name: "movie001.mp4")]),
                                 FileItem(name: "Documents", children: [])
                                ]),
                     FileItem(name: "newuser", children:
                                [FileItem(name: "Documents", children: [])
                                ])
                    ]),
        FileItem(name: "private", children: nil)
    ]
    
    @State private var multiSelection = Set<UUID>()
    
    public init() {}
    public var body: some View {
        VStack {
            HStack {
                List {
                    Text("A List Item")
                    Text("A Second List Item")
                    Text("A Third List Item")
                }
                Divider()
                List(oceans) {
                    Text($0.name)
                }
            }
            Divider()
            HStack {
                NavigationView {
                    List(selection: $multiSelection) {
                        Section {
                            ForEach(oceans) {
                                Text($0.name)
                            }
                        } header: {
                            Text("\(multiSelection.count) selections")
                                .font(.caption)
                                .opacity(0.5)
                        }
                    }
                    .navigationTitle("Oceans")
#if os(iOS)
                    .toolbar {
                        EditButton()
                    }
#endif
                }
                Divider()
                List(fileHierarchyData, children: \.children) { item in
                    Text(item.description)
                }
            }
        }
    }
}

struct P134_List_Previews: PreviewProvider {
    static var previews: some View {
        P134_List()
    }
}
