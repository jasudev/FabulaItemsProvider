//
//  P153_SimultaneousGesture.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P153_SimultaneousGesture: View {
    
    @State private var normalText: String = ""
    @State private var simultaneousText: String = ""
    
    public init() {}
    public var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Normal")
                        .font(.caption)
                        .opacity(0.5)
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 200, height: 200)
                        .overlay(
                            Text("Tap")
                        )
                        .onTapGesture {
                            normalText += "Circle tapped" + "\n"
                        }
                }
                ScrollView {
                    Text(normalText)
                        .font(.caption)
                        .lineLimit(nil)
                        .foregroundColor(Color.fabulaPrimary)
                        .padding(.trailing, 12)
                }
                .frame(maxHeight: 200)
                .animation(.none, value: normalText)
            }
            .animation(.easeInOut, value: normalText)
            .onTapGesture {
                normalText += "HStack tapped" + "\n"
            }
            
            Divider().padding()
            
            HStack {
                VStack {
                    Text("Simultaneous")
                        .font(.caption)
                        .opacity(0.5)
                    Circle()
                        .fill(Color.green)
                        .frame(width: 200, height: 200)
                        .overlay(
                            Text("Tap")
                        )
                        .onTapGesture {
                            simultaneousText += "Circle tapped" + "\n"
                        }
                }
                ScrollView {
                    Text(simultaneousText)
                        .font(.caption)
                        .lineLimit(nil)
                        .foregroundColor(Color.fabulaPrimary)
                        .padding(.trailing, 12)
                }
                .frame(maxHeight: 200)
                .animation(.none, value: simultaneousText)
            }
            .animation(.easeInOut, value: simultaneousText)
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        simultaneousText += "HStack tapped" + "\n"
                    }
            )
        }
    }
}

struct P153_SimultaneousGesture_Previews: PreviewProvider {
    static var previews: some View {
        P153_SimultaneousGesture()
    }
}
