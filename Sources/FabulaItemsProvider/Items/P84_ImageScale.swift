//
//  P84_ImageScale.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P84_ImageScale: View {
    
    public init() {}
    public var body: some View {
        HStack {
            HStack {
                Text("Small")
                ImageScaleView()
                    .environment(\.imageScale, .small)
            }
            Divider()
                .frame(height: 44)
                .padding()
            HStack {
                Text("Medium")
                ImageScaleView()
                    .imageScale(.medium)
            }
            Divider()
                .frame(height: 44)
                .padding()
            HStack {
                Text("Large")
                ImageScaleView()
                    .imageScale(.large)
            }
        }
    }
}

fileprivate
struct ImageScaleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "swift")
            Image(systemName: "swift")
            Image(systemName: "swift")
        }
    }
}


struct P84_ImageScale_Previews: PreviewProvider {
    static var previews: some View {
        P84_ImageScale()
    }
}
