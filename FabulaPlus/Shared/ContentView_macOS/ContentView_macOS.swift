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
    @StateObject private var viewModel = MacViewModel()
    
    let sideHeight: CGFloat = 360
    
    var listView: some View {
        let items = ItemsProvider.shared.itemsByPlatform
        return List(items) { item in
            Button {
                viewModel.currentItem = item
            } label: {
                ItemRowView(itemData: item)
                    .padding(.bottom, 10)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                listView
                    .frame(width: sideHeight)
                    .offset(x: viewModel.isShowSideList ? 0 : -sideHeight)
            }
            .frame(width: viewModel.isShowSideList ? sideHeight : 0)
            ZStack {
                Color.fabulaBack1
                VStack(spacing: 0) {
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                viewModel.isShowSideList.toggle()
                            }
                        }, label: {
                            Image(systemName: "sidebar.left")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.accentColor)
                                .frame(width: 22, height: 22)
                        })
                        Spacer()
                        Toggle(colorSchemeDark ? "Light" : "Dark", isOn: $colorSchemeDark)
                    }
                    .buttonStyle(.plain)
                    .padding()
                    
                    ZStack {
                        Color.clear
                        if let item =  viewModel.currentItem {
                            item.view
                        } else {
                            HomeView()
                        }
                    }
                }
            }
            .clipped()
        }
        .navigationTitle("FabulaPlus")
        .environmentObject(viewModel)
        .environment(\.colorScheme, colorSchemeDark ? ColorScheme.dark : ColorScheme.light)
    }
}

struct ContentView_macOS_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_macOS()
    }
}
