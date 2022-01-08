//
//  P142_PageIndexViewStyle.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P142_PageIndexViewStyle: View {
    
#if os(iOS)
    @State private var items = ["Screen 1", "Screen 2", "Screen 3"]
    
    @State private var tabViewStyleIndex: Int = 0
    @State private var indexViewStyleIndex: Int = 0
    
    public init() {}
    public var body: some View {
        VStack {
            TabView {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.fabulaPrimary)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: getTabViewStyleIndexWithIndex(tabViewStyleIndex).1))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: getIndexDisplayModeWithIndex(indexViewStyleIndex).1))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("PageTabViewStyle")
                        .font(.caption)
                        .opacity(0.5)
                    Picker("PageTabViewStyle", selection: $tabViewStyleIndex) {
                        ForEach(0...2, id: \.self) { index in
                            Text(getTabViewStyleIndexWithIndex(index).0).tag(index)
                        }
                    }
                }
                
                Divider().frame(height: 36).padding()
                
                VStack(alignment: .leading) {
                    Text("PageIndexViewStyle")
                        .font(.caption)
                        .opacity(0.5)
                    Picker("PageIndexViewStyle", selection: $indexViewStyleIndex) {
                        ForEach(0...3, id: \.self) { index in
                            Text(getIndexDisplayModeWithIndex(index).0).tag(index)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private func getTabViewStyleIndexWithIndex(_ index: Int) -> (String, PageTabViewStyle.IndexDisplayMode) {
        switch index {
        case 0: return ("always", PageTabViewStyle.IndexDisplayMode.always)
        case 1: return ("automatic", PageTabViewStyle.IndexDisplayMode.automatic)
        case 2: return ("never", PageTabViewStyle.IndexDisplayMode.never)
        default : return ("automatic", PageTabViewStyle.IndexDisplayMode.automatic)
        }
    }
    
    private func getIndexDisplayModeWithIndex(_ index: Int) -> (String, PageIndexViewStyle.BackgroundDisplayMode) {
        switch index {
        case 0: return ("always", PageIndexViewStyle.BackgroundDisplayMode.always)
        case 1: return ("automatic", PageIndexViewStyle.BackgroundDisplayMode.automatic)
        case 2: return ("interactive", PageIndexViewStyle.BackgroundDisplayMode.interactive)
        case 3: return ("never", PageIndexViewStyle.BackgroundDisplayMode.never)
        default: return ("automatic", PageIndexViewStyle.BackgroundDisplayMode.automatic)
        }
    }
#else
    public init() {}
    public var body: some View {
        EmptyView()
    }
#endif
}

struct P142_PageIndexViewStyle_Previews: PreviewProvider {
    static var previews: some View {
        P142_PageIndexViewStyle()
    }
}
