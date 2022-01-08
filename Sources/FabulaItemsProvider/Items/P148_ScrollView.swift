//
//  P148_ScrollView.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P148_ScrollView: View {
    
    public init() {}
    public  var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: true) {
            VStack(alignment: .leading) {
                ForEach(0..<10) {
                    Text("Row \($0)")
                }
            }
        }
    }
}

struct P148_ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        P148_ScrollView()
    }
}
