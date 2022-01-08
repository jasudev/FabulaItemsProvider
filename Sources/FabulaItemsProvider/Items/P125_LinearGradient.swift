//
//  P125_LinearGradient.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P125_LinearGradient: View {
    
    let gradient = Gradient(colors: [.red, .green, .blue])
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(
                    gradient: gradient,
                    startPoint: .leading,
                    endPoint: .trailing))
        }
        .padding()
        .frame(maxWidth: 300, maxHeight: 300)
    }
}

struct P125_LinearGradient_Previews: PreviewProvider {
    static var previews: some View {
        P125_LinearGradient()
    }
}
