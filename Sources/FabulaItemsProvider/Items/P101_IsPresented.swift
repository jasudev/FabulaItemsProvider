//
//  P101_IsPresented.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P101_IsPresented: View {
    
    @State private var showDetail: Bool = false
    
    public init() {}
    public var body: some View {
        Button {
            showDetail = true
        } label: {
            Text("Show Detail")
        }
        .sheet(isPresented: $showDetail) {
            if #available(macOS 12.0, *) {
                DetailView()
            } else {
                Text("Availability\niOS 15.0+\niPadOS 15.0+\nmacOS 12.0+\nMac Catalyst 15.0+\ntvOS 15.0+\nwatchOS 8.0+")
            }
        }
    }
}

@available(macOS 12.0, *)
fileprivate
struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss: DismissAction
    @Environment(\.isPresented) var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text(isPresented ? "isPresented == true" : "isPresented == false")
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
#if os(macOS)
        .frame(width: 300, height: 400)
#endif
    }
}

struct P101_IsPresented_Previews: PreviewProvider {
    static var previews: some View {
        P101_IsPresented()
    }
}
