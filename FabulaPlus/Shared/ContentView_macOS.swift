//
//  ContentView_macOS.swift
//  FabulaPlus
//
//  Created by jasu on 2022/01/05.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import FabulaItemsProvider

struct ContentView_macOS: View {
    
    @AppStorage("colorSchemeDark") var colorSchemeDark: Bool = true
    
    var listView: some View {
        let items = ItemsProvider.shared.itemsByPlatform
        return List(items) { item in
            NavigationLink {
                item.view
            } label: {
                ItemRowView(itemData: item)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            listView
                .padding()
                .toolbar {
                    ToolbarItemGroup {
                        Button(action: {
                            NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                        }, label: {
                            Image(systemName: "sidebar.left")
                                .foregroundColor(Color.accentColor)
                        })
                        Spacer()
                        Toggle(colorSchemeDark ? "Light" : "Dark", isOn: $colorSchemeDark)
                    }
                }
                .frame(minWidth: 360)
                .navigationTitle("Fabula+")
            
            HomeView()
        }
        .preferredColorScheme(colorSchemeDark ? ColorScheme.dark : ColorScheme.light)
    }
}

struct ContentView_macOS_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_macOS()
    }
}
