//
//  P126_RadialGradient.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P126_RadialGradient: View {
    
    let gradient = Gradient(colors: [.red, .green, .blue])
    
    public init() {}
    public var body: some View {
        Circle()
            .fill(RadialGradient(gradient: gradient, center: .center, startRadius: 1, endRadius: 100))
            .frame(width: 200, height: 200)
    }
}

struct P126_RadialGradient_Previews: PreviewProvider {
    static var previews: some View {
        P126_RadialGradient()
    }
}
