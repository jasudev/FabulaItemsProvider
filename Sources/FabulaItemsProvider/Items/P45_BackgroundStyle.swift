//
//  P45_BackgroundStyle.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P45_BackgroundStyle: View {
    
    @Environment(\.colorScheme) private var systemColorScheme
    
    public init() {}
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(BackgroundStyle())
                .padding()
            Text(systemColorScheme == .dark ? "Dark" : "Light")
                .foregroundColor(Color.gray)
        }
    }
}

struct P45_BackgroundStyle_Previews: PreviewProvider {
    static var previews: some View {
        P45_BackgroundStyle()
            .preferredColorScheme(.dark)
    }
}
