//
//  P56_TabView.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P56_TabView: View {
    
    @State private var selectTag: Int = 0
    @State private var tabIndex: Int = 0
    
    var tabView: some View {
        TabView(selection: $tabIndex) {
            ZStack {
                Color.red
                Text("Tab 1")
            }
            .tag(0)
            .tabItem {
                Image(systemName: "1.square.fill")
                Text("Tab 1")
            }
            ZStack {
                Color.green
                Text("Tab 2")
            }
            .tag(1)
            .tabItem {
                Image(systemName: "2.square.fill")
                Text("Tab 2")
            }
            ZStack {
                Color.blue
                Text("Tab 3")
            }
            .tag(2)
            .tabItem {
                Image(systemName: "3.square.fill")
                Text("Tab 3")
            }
        }
        .font(.headline)
        .accentColor(getAccentColor())
    }
    
    private func getAccentColor() -> Color {
        switch tabIndex {
        case 0: return Color.red
        case 1: return Color.green
        case 2: return Color.blue
        default: return Color.green
        }
    }
    
    public init() {
#if os(iOS)
        UITabBar.appearance().backgroundColor = UIColor.gray.withAlphaComponent(0.15)
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
#endif
    }
    public var body: some View {
#if os(iOS)
        VStack {
            Picker("TabViewStyle", selection: $selectTag) {
                Text("DefaultTabViewStyle")
                    .tag(0)
                Text("PageTabViewStyle")
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectTag == 0 {
                tabView
                    .tabViewStyle(DefaultTabViewStyle())
            }else {
                tabView
                    .tabViewStyle(PageTabViewStyle())
            }
        }
        .transition(.opacity)
        .animation(.easeInOut, value: selectTag)
#else
        tabView
            .tabViewStyle(DefaultTabViewStyle())
            .frame(maxWidth: 500, maxHeight: 500)
            .padding()
#endif
    }
}

struct P56_TabView_Previews: PreviewProvider {
    static var previews: some View {
        P56_TabView()
    }
}
