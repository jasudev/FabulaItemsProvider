//
//  P158_SubscriptionView.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P158_SubscriptionView: View {
    
    @State private var count1: Double = 0
    @State private var count2: Double = 0
    
    @State private var angle1 = Angle(degrees: 0)
    @State private var angle2 = Angle(degrees: 0)
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    public init() {}
    public var body: some View {
        ZStack {
            SubscriptionView(content:
                                StrokeCapsuleView(color: Color.purple)
                                .frame(width: 260, height: 100)
                                .rotationEffect(angle1)
                             , publisher: timer) { t in
                count1 += 1
                angle1 = Angle(degrees: count1 * 45)
            }
            StrokeCapsuleView(color: Color.orange)
                .frame(width: 100, height: 260)
                .rotationEffect(angle2)
                .onReceive(timer) { t in
                    count2 += 1
                    angle2 = Angle(degrees: count1 * -45)
                }
        }
        .animation(.easeOut, value: count1)
        .animation(.easeOut, value: count2)
    }
}

fileprivate
extension P158_SubscriptionView {
    struct StrokeCapsuleView: View {
        let color: Color
        var body: some View {
            Capsule()
                .stroke(lineWidth: 1)
                .foregroundColor(color)
        }
    }
}

struct P158_SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        P158_SubscriptionView()
    }
}
