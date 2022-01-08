//
//  P160_Text.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P160_Text: View {
    
    public init() {}
    public var body: some View {
        Text(Date(), style: .date)
            .font(.title)
            .bold()
            .foregroundColor(.orange)
            .italic()
            .strikethrough(true, color: Color.blue)
            .underline(true, color: Color.purple)
            .kerning(2)
            .tracking(4)
            .baselineOffset(5)
    }
}

struct P160_Text_Previews: PreviewProvider {
    static var previews: some View {
        P160_Text()
    }
}
