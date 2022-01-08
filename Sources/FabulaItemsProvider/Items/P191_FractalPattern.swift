//
//  P191_FractalPattern.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P191_FractalPattern: View {
    
    @State private var toggle: Bool = false

    public init() {}
    public var body: some View {
        VStack {
            if toggle {
                Particle(count: 2)
            }else {
                Particle(count: 2)
            }
            Spacer()
            Button {
                withAnimation {
                    toggle.toggle()
                }
            } label: {
                Text("Create")
                    .padding()
                    .background(Color.fabulaPrimary)
                    .foregroundColor(Color.white)
                    .cornerRadius(12)
                    .padding()
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
        }
        .padding()
    }
}

fileprivate
struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.width / 2, y: 0))
        p.addLines([CGPoint(x: rect.width / 2, y: 0),
                    CGPoint(x: rect.width, y: rect.height),
                    CGPoint(x: 0, y: rect.height),
                    CGPoint(x: rect.width / 2, y: 0)
                   ])
        return p
    }
}

fileprivate
let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C)]

fileprivate
struct RowView: View {
    var body: some View {
        ZStack {
            switch Int.random(in: 0..<3) {
            case 0: Rectangle()
                    .aspectRatio(1, contentMode: .fit)
            case 1: Capsule()
                    .aspectRatio(1, contentMode: .fit)
            case 2: Triangle()
                    .aspectRatio(1, contentMode: .fit)
            default:
                EmptyView()
            }
        }
    }
}

fileprivate
struct Particle: View {
    
    let count: Int
    
    private var rowView: some View {
        ZStack {
            let random = Bool.random()
            if random {
                HStack(spacing: 5) {
                    ForEach(0...2, id: \.self) { index in
                        Particle(count: count - 1)
                    }
                }
            }else {
                VStack(spacing: 5) {
                    ForEach(0...2, id: \.self) { index in
                        Particle(count: count - 1)
                    }
                }
            }
        }
    }
    
    var body: some View {
        let random = Bool.random()
        ZStack {
            if count > 0 {
                if random {
                    VStack(spacing: 5) {
                        ForEach(0...2, id: \.self) { index in
                            rowView
                        }
                    }
                }else {
                    HStack(spacing: 5) {
                        ForEach(0...2, id: \.self) { index in
                            rowView
                        }
                    }
                }
                
            } else {
                RowView()
                    .foregroundColor(colors[Int.random(in: 0..<colors.count)])
            }
        }
    }
}



struct P191_FractalPattern_Previews: PreviewProvider {
    static var previews: some View {
        P191_FractalPattern()
    }
}
