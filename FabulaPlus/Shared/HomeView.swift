//
//  HomeView.swift
//  FabulaPlus
//
//  Created by jasu on 2022/01/01.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isPlaceholder: Bool = true

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .fill(Color.fabulaBack1)
                Image("fabulaIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.fabulaFore1.opacity(0.03))
                    .frame(width: proxy.minSize * 0.5, height: proxy.minSize * 0.5)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
