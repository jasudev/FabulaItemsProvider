//
//  P157_StrokeStyle.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P157_StrokeStyle: View {
    
    public init() {}
    public var body: some View {
        ZStack {
            StrokeCapsuleView()
                .foregroundColor(Color.purple)
                .frame(width: 200, height: 100)
            StrokeCapsuleView()
                .foregroundColor(Color.orange)
                .frame(width: 100, height: 200)
        }
        .padding()
    }
}

fileprivate
extension P157_StrokeStyle {
    
    struct StrokeCapsuleView: View {
        let style = StrokeStyle(lineWidth: 1,
                                lineCap: .round,
                                lineJoin: .miter,
                                miterLimit: 0,
                                dash: [2, 6],
                                dashPhase: 0)
        var body: some View {
            Capsule()
                .stroke(style: style)
        }
    }
}


struct P157_StrokeStyle_Previews: PreviewProvider {
    static var previews: some View {
        P157_StrokeStyle()
    }
}

