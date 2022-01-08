//
//  P187_HierarchyTree.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P187_HierarchyTree: View {
    
    @State private var item = TreeItem(name: "Root", children: [])
    
    public init() {}
    public var body: some View {
        ScrollView([.vertical, .horizontal]) {
            TreeView(item: item)
        }
        .onAppear {
            item = TreeItem(name: "Root", children: [])
        }
    }
}

fileprivate
class TreeItem: ObservableObject, Identifiable {
    
    var id: UUID = UUID()
    @Published var name: String
    @Published var children: [TreeItem]
    
    init(name: String, children: [TreeItem]) {
        self.children = children
        self.name = name
    }
}

fileprivate
struct TreeView: View {
    
    @ObservedObject var item: TreeItem
    typealias Key = PreferKey<TreeItem.ID, Anchor<CGPoint>>
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            HStack(spacing: 5) {
                Image(systemName: "minus.circle")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            item.children = []
                        }
                    }
                TextField("", text: $item.name)
                    .padding(.vertical, 6).padding(.horizontal, 10)
                    .background(Color.white.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundColor(Color.white)
                    .fixedSize()
                Image(systemName: "plus.circle")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        let treeItem = TreeItem(name: "Child", children: [])
                        withAnimation(.easeInOut(duration: 0.4)) {
                            item.children.append(treeItem)
                        }
                    }
            }
            .padding(12)
            .background(Color.fabulaPrimary)
            .clipShape(Capsule())
            .anchorPreference(key: Key.self, value: .center, transform: {
                [self.item.id: $0]
            })

            HStack(alignment: .top, spacing: 10) {
                ForEach(Array(item.children.enumerated()), id:\.offset) { index, i in
                    HStack {
                        TreeView(item: i)
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.4), value: item.name)
        .backgroundPreferenceValue(Key.self, { (centers: [TreeItem.ID: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                ForEach(self.item.children) { child in
                    Line(
                        startPoint: proxy[centers[self.item.id]!],
                        endPoint: proxy[centers[child.id]!]
                    )
                        .stroke(lineWidth: 1)
                        .fill(Color.fabulaPrimary)
                }
            }
        })
    }
}

fileprivate
struct PreferKey<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key: Value] { [:] }
    static func reduce(value: inout [Key: Value], nextValue: () -> [Key: Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

fileprivate
struct Line: Shape {
    var startPoint: CGPoint
    var endPoint: CGPoint
    var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
        get { AnimatablePair(startPoint.animatableData, endPoint.animatableData) }
        set { (startPoint.animatableData, endPoint.animatableData) = (newValue.first, newValue.second) }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.startPoint)
            p.addLine(to: self.endPoint)
        }
    }
}

struct P187_HierarchyTree_Previews: PreviewProvider {
    static var previews: some View {
        P187_HierarchyTree()
    }
}
