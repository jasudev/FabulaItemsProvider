//
//  P127_Image.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P127_Image: View {
    
    let divideValue = 2.0
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                HStack(spacing: 0) {
                    Image(systemName: "sun.dust")
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.size.width / divideValue, height: proxy.size.height / divideValue)
                        .scaleEffect(0.5)
                        .clipped()
                    Image(systemName: "moon.stars")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(width: proxy.size.width / divideValue, height: proxy.size.height / divideValue)
                        .scaleEffect(0.5)
                        .clipped()
                }
            }
        }
        .padding()
    }
}

struct P127_Image_Previews: PreviewProvider {
    static var previews: some View {
        P127_Image()
    }
}
