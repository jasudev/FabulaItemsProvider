//
//  P65_EmptyView.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P65_EmptyView: View {
    
    @State private var showCircle: Bool = false
    
    public init() {}
    public var body: some View {
        VStack {
            HStack {
                Text("Hello")
                if showCircle {
                    Circle()
                        .fill(Color.fabulaPrimary)
                        .frame(width: 5, height: 5)
                }else {
                    EmptyView()
                        .padding()
                        .frame(width: 100, height: 100)
                        .background(Color.fabulaPrimary)
                }
                Text("World")
            }
            Divider().padding()
            if #available(macOS 12.0, *) {
                Toggle("showCircle", isOn: $showCircle)
                    .tint(Color.fabulaPrimary)
                    .frame(width: 300)
                    .padding()
            } else {
                Toggle("showCircle", isOn: $showCircle)
                    .frame(width: 300)
                    .padding()
            }
        }
        .animation(.spring(), value: showCircle)
        .frame(maxWidth: 500)
    }
}

struct P65_EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        P65_EmptyView()
    }
}
