//
//  P129_LabelStyle.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P129_LabelStyle: View {
    
    public init() {}
    public var body: some View {
        VStack {
            Label("Sun", systemImage: "sun.max")
                .labelStyle(WeatherLabelStyle(color: .green))
            Divider().frame(width: 44).padding()
            Label("Cloud", systemImage: "cloud.drizzle")
                .labelStyle(WeatherLabelStyle(color: .red))
        }
        .font(.title)
    }
}

fileprivate
struct WeatherLabelStyle: LabelStyle {
    
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
                .foregroundColor(color)
        }
    }
}

struct P129_LabelStyle_Previews: PreviewProvider {
    static var previews: some View {
        P129_LabelStyle()
    }
}
