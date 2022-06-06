//
//  ContentView_iOS.swift
//  FabulaPlus
//
//  Created by jasu on 2022/01/05.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import FabulaItemsProvider

struct ContentView_iOS: View {
    
    @AppStorage("colorSchemeDark") var colorSchemeDark: Bool = true
    
    var listView: some View {
        let items = ItemsProvider.shared.itemsByPlatform
        return List(items) { item in
            NavigationLink {
                item.view
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarColor(backgroundColor: Color.clear, titleColor: Color.fabulaPrimary)
                    .onAppear {
                        vibration()
                    }
                    .background(Color.fabulaBack1)
            } label: {
                ItemRowView(itemData: item)
            }
        }
        .listRowBackground(Color.clear)
        .accentColor(Color.fabulaFore1.opacity(0.1))
    }
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        if isPad {
            content()
                .navigationViewStyle(.columns)
        } else {
            content()
                .navigationViewStyle(.stack)
        }
    }
    
    private func content() -> some View {
        NavigationView {
            listView
                .background(Color.fabulaBar1)
                .toolbar {
                    Toggle(colorSchemeDark ? "Light" : "Dark", isOn: $colorSchemeDark)
                        .onChange(of: colorSchemeDark) { value in
                            vibration()
                        }
                }
                .navigationBarColor(backgroundColor: Color.fabulaBar1, titleColor: Color.fabulaPrimary)
                .edgesIgnoringSafeArea(.bottom)
                .navigationTitle("FabulaPlus")
            
            HomeView()
                .edgesIgnoringSafeArea(.top)
                .navigationBarColor(backgroundColor: Color.clear, titleColor: Color.fabulaPrimary)
                .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(colorSchemeDark ? ColorScheme.dark : ColorScheme.light)
    }
}

struct ContentView_iOS_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_iOS()
    }
}
