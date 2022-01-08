//
//  P11_AngularGradient.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P11_AngularGradient: View {
    
    let colors: [Color] = [.yellow, .red,.blue, .purple]
    
    public init() {}
    public var body: some View {
        Circle()
            .fill(AngularGradient(gradient: Gradient(colors: colors), center: .center,startAngle: .degrees(0), endAngle: .degrees(360)))
            .padding(60)
            .shadow(radius: 6)
        
    }
}

struct P11_AngularGradient_Previews: PreviewProvider {
    static var previews: some View {
        P11_AngularGradient()
    }
}
