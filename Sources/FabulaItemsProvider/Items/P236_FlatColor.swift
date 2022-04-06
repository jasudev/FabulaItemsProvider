//
//  P236_FlatColor.swift
//  
//
//  Created by jasu on 2022/04/06.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

public struct P236_FlatColor: View {
    
    @State private var selection: Int = 0
    let colors: [String] = ["F26627", "F9A26C", "EFEEEE", "9BD7D1", "325D79"]
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black
                    .overlay(
                        AxisSegmentedView(selection: $selection, constant: .init(axisMode: .vertical)) {
                            ForEach(0..<colors.count, id: \.self) { index in
                                Rectangle()
                                    .fill(Color(hex: colors[index]))
                                    .itemTag(index, selectArea: 300) {
                                        Rectangle()
                                            .fill(Color(hex: colors[index]))
                                    }
                            }
                        }
                            .opacity(0.8)
                            .blur(radius: 100)
                            .frame(width: proxy.size.width * 1.5)
                    )
                
                AxisSegmentedView(selection: $selection, constant: .init(axisMode: .vertical)) {
                    ForEach(0..<colors.count, id: \.self) { index in
                        itemView(color: colors[index])
                            .itemTag(index, selectArea: 200) {
                                itemView(color: colors[index])
                            }
                    }
                }
                .background(
                    Color.black
                        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
                )
                .frame(width: proxy.size.width * 0.8, height: proxy.size.height * 0.5)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func itemView(color: String) -> some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(Color(hex: color))
            Text("#\(color)")
                .padding([.leading, .bottom], 12)
                .font(.caption)
                .foregroundColor(.black)
        }
    }
}

struct P236_FlatColor_Previews: PreviewProvider {
    static var previews: some View {
        P236_FlatColor()
    }
}
