//
//  P241_Mask.swift
//  References : https://www.youtube.com/watch?v=1BHHybRnHFE
//
//  Created by jasu on 2022/04/27.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

struct P241_Mask: View {
    
    private let colors: [Color] = [.yellow, .red,.blue, .purple]
    
    var body: some View {
        
        VStack {
            // use mask
            AngularGradient(colors: colors, center: .center)
                .mask(
                    Circle()
                        .stroke(lineWidth: 50)
                        .fill(Color.fabulaPrimary)
                        .padding(40)
                )
            // use maskContent
            Circle()
                .stroke(lineWidth: 50)
                .fill(Color.fabulaPrimary)
                .padding(40)
                .maskContent(using: AngularGradient(colors: colors, center: .center))
        }
    }
}

struct P241_Mask_Previews: PreviewProvider {
    static var previews: some View {
        P241_Mask()
    }
}

fileprivate
extension View {
    func maskContent<T: View>(using: T) -> some View {
        using.mask(self)
    }
}
