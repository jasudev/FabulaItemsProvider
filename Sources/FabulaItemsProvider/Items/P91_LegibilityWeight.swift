//
//  P91_LegibilityWeight.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P91_LegibilityWeight: View {
    
    @Environment(\.legibilityWeight) private var legibilityWeight: LegibilityWeight?
    
    public init() {}
    public var body: some View {
        VStack {
            LegibilityWeightView()
                .environment(\.legibilityWeight, .bold)
            Divider()
                .frame(width: 44)
                .padding()
            LegibilityWeightView()
                .environment(\.legibilityWeight, .regular)
        }
    }
}

fileprivate
struct LegibilityWeightView: View {
    
    @Environment(\.legibilityWeight) private var legibilityWeight: LegibilityWeight?
    
    var body: some View {
        VStack {
            if legibilityWeight == .bold {
                Text("legibilityWeight: bold")
                    .fontWeight(.bold)
            } else {
                Text("legibilityWeight: regular")
                    .fontWeight(.regular)
            }
        }
    }
}

struct P91_LegibilityWeight_Previews: PreviewProvider {
    static var previews: some View {
        P91_LegibilityWeight()
    }
}
