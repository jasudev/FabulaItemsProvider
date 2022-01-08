//
//  P36_WithAnimation.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P36_WithAnimation: View {
    
    @State private var showIcon = false
    
    public init() {}
    public var body: some View {
        HStack {
            if showIcon {
                Image(systemName: "airplane")
                    .font(.largeTitle)
                    .transition(.slide.combined(with: .opacity))
            }
            
            Text(showIcon ? "Hide" : "Show")
                .font(.title)
                .padding()
                .animation(Animation.easeInOut, value: showIcon)
                .onTapGesture {
                    withAnimation(.easeInOut) { showIcon.toggle() }
                }
        }
    }
}

struct P36_WithAnimation_Previews: PreviewProvider {
    static var previews: some View {
        P36_WithAnimation()
    }
}
