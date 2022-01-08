//
//  P122_GeometryReader.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P122_GeometryReader: View {
    
    public init() {}
    public var body: some View {
        VStack {
            GeometryReader { (proxy: GeometryProxy) in
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("W : \(proxy.size.width) - H : \(proxy.size.height)")
                            .font(.callout)
                            .padding([.leading, .bottom])
                        Spacer()
                    }
                }
                Color.green
                    .frame(
                        width: proxy.size.width / 2,
                        height: proxy.size.height / 2
                    )
            }
            .border(Color.green, width: 1)
            
            GeometryReader { proxy in
                ZStack {
                    Color.clear
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("W : \(proxy.size.width) - H : \(proxy.size.height)")
                                .font(.callout)
                                .padding([.leading, .bottom])
                            Spacer()
                        }
                    }
                    Color.red
                        .frame(
                            width: proxy.size.width / 2,
                            height: proxy.size.height / 2
                        )
                }
            }
            .border(Color.red, width: 1)
        }
        .padding()
        .frame(maxWidth: 500, maxHeight: 1000)
    }
}

struct P122_GeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        P122_GeometryReader()
    }
}
