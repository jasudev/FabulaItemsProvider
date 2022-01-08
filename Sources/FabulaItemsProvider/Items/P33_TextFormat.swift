//
//  P33_TextFormat.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P33_TextFormat: View {
    
    @State private var numbers = [Int]()
    
    public init() {}
    public var body: some View {
#if os(iOS)
        VStack {
            Text(numbers, format: .list(memberStyle: .number, type: .and))
            VStack {
                if !numbers.isEmpty {
                    Button("RemoveAll") {
                        numbers = []
                    }
                    .buttonStyle(P33_ButtonStyle(backgroundColor: Color.red))
                }
                Button("Add") {
                    let result = Int.random(in: 1000...3000)
                    numbers.append(result)
                }
                .buttonStyle(P33_ButtonStyle(backgroundColor: Color.blue))
                
                
            }
            .animation(.easeInOut(duration: 0.3), value: numbers)
        }
        .padding()
#else
        EmptyView()
#endif
    }
}

fileprivate
struct P33_ButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .background(backgroundColor)
            .foregroundColor(Color.white)
            .cornerRadius(10)
    }
}

struct P33_TextFormat_Previews: PreviewProvider {
    static var previews: some View {
        P33_TextFormat().preferredColorScheme(.dark)
    }
}
