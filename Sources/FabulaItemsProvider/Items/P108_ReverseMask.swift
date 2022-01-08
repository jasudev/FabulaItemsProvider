//
//  P108_ReverseMask.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P108_ReverseMask: View {
    var maskView: some View {
        Image(systemName: "facemask.fill")
            .font(.largeTitle)
            .padding()
            .border(Color.fabulaPrimary, width: 2)
            .padding()
            .border(Color.fabulaPrimary, width: 2)
    }
    
    public init() {}
    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image("cat")
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .aspectRatio(contentMode: .fill)
            }
#if os(iOS)
            VStack {
                Rectangle()
                    .fill(Color.fabulaPrimary)
                    .mask { maskView }
                Rectangle()
                    .fill(Color.fabulaPrimary)
                    .reverseMask { maskView }
            }
#endif
        }
    }
}

#if os(iOS)
fileprivate
extension View {
    func reverseMask<T: View>(alignment: Alignment = .center, @ViewBuilder _ maskView: () -> T) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    maskView()
                        .blendMode(.destinationOut)
                }
        }
    }
}
#endif

struct P108_ReverseMask_Previews: PreviewProvider {
    static var previews: some View {
        P108_ReverseMask()
    }
}
