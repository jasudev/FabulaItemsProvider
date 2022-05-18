//
//  P247_ScrollViewAlign.swift
//  
//
//  Created by jasu on 2022/05/15.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSheet

public struct P247_ScrollViewAlign: View {
    
    @State private var isPresented: Bool = false
    @State private var scrollHeight: CGFloat = 100
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                GeometryReader { proxy in
                    ScrollView {
                        VStack {
                            ForEach(0..<15, id:\.self) { index in
                                Text("Item \(index)")
                            }
                        }
                        .frame(minWidth: proxy.size.width, minHeight: proxy.size.height - 1)
                    }
                }
                .frame(width: 360, height: scrollHeight)
                .background(Color.fabulaSecondary.opacity(0.2))
                .padding()
                
                ZStack {
                    Slider(value: $scrollHeight, in: 100...proxy.size.height - 50)
                        .padding()
                }
                .frame(height: 120)
                .background(Color.fabulaBack0.opacity(0.5))
                .axisSheet(isPresented: $isPresented, constants: .init(size: 120))
            }
        }
    }
}

struct P247_ScrollViewAlign_Previews: PreviewProvider {
    static var previews: some View {
        P247_ScrollViewAlign()
    }
}
