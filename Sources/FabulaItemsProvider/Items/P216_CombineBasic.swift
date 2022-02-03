//
//  P216_CombineBasic.swift
//  
//
//  Created by jasu on 2022/02/02.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import Combine

public struct P216_CombineBasic: View {
    
    @State private var value: Int = 0
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading) {
            Text("Just(216).sink { v in \n        value = v\n}")
                .font(.title2)
                .bold()
            Divider().frame(width: 44)
            VStack(alignment: .leading) {
                Text("Results : ")
                Text("\(value)")
            }
            .font(.headline)
            .foregroundColor(Color.fabulaPrimary)
        }
        .onAppear {
            let _ = Just(216).sink { v in
                value = v
            }
        }
    }
}

struct P216_CombineBasic_Previews: PreviewProvider {
    static var previews: some View {
        P216_CombineBasic()
    }
}
