//
//  P193_FractalMaker.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P193_FractalMaker: View {
    
    @State private var toggle: Bool = false
    @Namespace var namespace
    
    var item: some View {
        ZStack {
            if toggle {
                Item(count: 2, shapeIndex: 0)
            }else {
                Item(count: 2, shapeIndex: 0)
            }
        }
    }
    
    var button: some View {
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
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                if proxy.size.width < proxy.size.height {
                    VStack(spacing: 0) {
                        item.border(Color.fabulaPrimary, width: 1)
                        button.padding()
                    }
                }else {
                    HStack(spacing: 0) {
                        item.border(Color.fabulaPrimary, width: 1)
                        button.padding()
                    }
                }
            }
        }
        .padding()
    }
}

fileprivate
struct Triangle: Shape {
    let rotateIndex: Int
    func path(in rect: CGRect) -> Path {
        var p = Path()
        switch rotateIndex {
        case 0:
            p.move(to: CGPoint(x: 0, y: 0))
            p.addLines([CGPoint(x: rect.width, y: rect.height),
                        CGPoint(x: 0, y: rect.height),
                        CGPoint(x: 0, y: 0)
                       ])
        case 1:
            p.move(to: CGPoint(x: rect.width, y: 0))
            p.addLines([CGPoint(x: rect.width, y: rect.height),
                        CGPoint(x: 0, y: rect.height),
                        CGPoint(x: rect.width, y: 0)
                       ])
        case 2:
            p.move(to: CGPoint(x: 0, y: 0))
            p.addLines([CGPoint(x: rect.width, y: 0),
                        CGPoint(x: rect.width, y: rect.height),
                        CGPoint(x: 0, y: 0)
                       ])
        case 3:
            p.move(to: CGPoint(x: 0, y: 0))
            p.addLines([CGPoint(x: rect.width, y: 0),
                        CGPoint(x: 0, y: rect.height),
                        CGPoint(x: 0, y: 0)
                       ])
        default:
            break
        }
        
        return p
    }
}

fileprivate
struct RowView: View {
    
    let shapeIndex: Int
    
    var body: some View {
        ZStack {
            switch shapeIndex {
            case 0:
                Triangle(rotateIndex: Int.random(in: 0..<4))
                    .aspectRatio(1, contentMode: .fit)
                    .opacity(0.5)
            case 1:
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(Color.fabulaPrimary)
            default:
                EmptyView()
            }
        }
    }
}

fileprivate
struct Item: View {
    let count: Int
    let shapeIndex: Int
    var body: some View {
        if count <= 0 {
            RowView(shapeIndex: shapeIndex)
        }else {
            VStack(spacing: 0) {
                randomItems()
                randomItems()
                randomItems()
            }
        }
    }
    
    private func randomItems() -> some View {
        ZStack {
            switch Int.random(in: 0...2) {
            case 0:
                HStack(spacing: 0) {
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: Int.random(in: 0..<2))
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                }
            case 1:
                HStack(spacing: 0) {
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                }
            case 2:
                HStack(spacing: 0) {
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                    Item(count: count - (Bool.random() ? 1 : 2), shapeIndex: 0)
                }
            default:
                EmptyView()
            }
        }
    }
}

struct P193_FractalMaker_Previews: PreviewProvider {
    static var previews: some View {
        P193_FractalMaker()
    }
}
