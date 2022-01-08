//
//  P138_NavigationLink.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P138_NavigationLink: View {
    
    enum NaviItem {
        case left
        case right
        case up
        case down
    }
    
    var selectLink: some View {
        VStack(spacing: 10) {
            NavigationLink(
                destination:
                    Image(systemName: "arrow.left.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color.fabulaPrimary)
                    .navigationTitle("Left"),
                tag: NaviItem.left,
                selection: $selectItem
            ) {
                Text("Show Left")
            }
            
            NavigationLink(
                destination:
                    Image(systemName: "arrow.right.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color.fabulaPrimary)
                    .navigationTitle("Right"),
                tag: NaviItem.right,
                selection: $selectItem
            ) {
                Text("Show Right")
            }
            
            NavigationLink(
                destination:
                    Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color.fabulaPrimary)
                    .navigationTitle("Up"),
                tag: NaviItem.up,
                selection: $selectItem
            ) {
                Text("Show Up")
            }
            
            NavigationLink(
                destination:
                    Image(systemName: "arrow.down.square.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color.fabulaPrimary)
                    .navigationTitle("Down"),
                tag: NaviItem.down,
                selection: $selectItem
            ) {
                Text("Show Down")
            }
        }
    }
    
    @State private var selectItem: NaviItem? = nil
    
    struct HeartView: View {
        var body: some View {
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(Color.fabulaPrimary)
                .navigationTitle("Heart")
        }
    }
    
    public init() {}
    public var body: some View {
        VStack(spacing: 30){
#if os(iOS)
            NavigationLink(destination: HeartView()) {
                Text("Show Heart")
            }
#else
            NavigationView {
                NavigationLink(destination: HeartView()) {
                    Text("Show Heart")
                }
            }
#endif
            selectLink
        }
    }
}

struct P138_NavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            P138_NavigationLink()
        }
    }
}
