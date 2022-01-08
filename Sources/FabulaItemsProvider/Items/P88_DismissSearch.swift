//
//  P88_DismissSearch.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

#if os(iOS)
public struct P88_DismissSearch: View {
    
    @State private var text: String = ""
    
    public init() {}
    public var body: some View {
        MainScreenView()
            .searchable(text: $text, prompt: Text("Search..."))
    }
}

fileprivate
struct MainScreenView: View {
    
    @State private var isPresented = false
    @Environment(\.isSearching) private var isSearching
    
    var body: some View {
        ZStack {
            if isSearching {
                Button {
                    isPresented = true
                } label: {
                    Text("Show SubView")
                        .padding()
                }
                .sheet(isPresented: $isPresented) {
                    NavigationView {
                        SubScreenView()
                    }
                }
            }else {
                Text("MainView")
            }
        }
    }
}

fileprivate
struct SubScreenView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.dismissSearch) private var dismissSearch
    
    var body: some View {
        Text("SubScreenView")
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading){
                    Button("dismiss") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("dismissSearch") {
                        dismissSearch()
                    }
                }
            }
    }
}
#else
public struct P88_DismissSearch: View {
    
    public init() {}
    public var body: some View {
        EmptyView()
    }
}
#endif

struct P88_DismissSearch_Previews: PreviewProvider {
    static var previews: some View {
        P88_DismissSearch()
    }
}
