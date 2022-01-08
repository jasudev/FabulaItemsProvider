//
//  P179_FoldUnfold.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P179_FoldUnfold: View {
    
    @State private var height: CGFloat = 70
    @State private var rowMaxHeight: CGFloat = 100
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack(spacing: 0) {
                PaperView(maxHeight: rowMaxHeight, height: $height)
                PaperView(maxHeight: rowMaxHeight, height: $height)
            }
            .frame(height: rowMaxHeight * 2)
            
            Divider().padding()
            Spacer()
            VStack(alignment: .leading, spacing: 3) {
                Text("Row Height:")
                    .font(.caption)
                    .opacity(0.5)
                Slider(value: $rowMaxHeight.animation(), in: 70...200)
                Text("Fold - Unfold:")
                    .font(.caption)
                    .opacity(0.5)
                Slider(value: $height, in: 0...rowMaxHeight)
            }
            
            HStack {
                Text("Fold")
                    .bold()
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.fabulaPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)) {
                            height = 0
                        }
                    }
                Text("Unfold")
                    .bold()
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.fabulaPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)) {
                            height = rowMaxHeight
                        }
                    }
            }
            .padding(.bottom)
        }
        .padding()
        .frame(maxWidth: 500)
    }
}

fileprivate
struct RowView: View {
    
    let maxHeight: CGFloat
    
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                Text("Row Title")
                    .font(.callout)
                    .bold()
                Spacer()
            }
            .foregroundColor(Color.white)
            .padding()
        }
        .frame(height: maxHeight)
        .clipped()
        .background(Color.fabulaPrimary)
    }
}

fileprivate
struct PaperView: View {
    
    let maxHeight: CGFloat
    @Binding var height: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            RowView(maxHeight: maxHeight)
                .overlay(
                    LinearGradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .opacity((1.0 - (height / maxHeight)))
                )
                .rotation3DEffect(Angle(degrees: -90 * (1.0 - (height / maxHeight))), axis: (x: 1, y: 0, z: 0), anchor: .top)
                .frame(height: height * 0.5, alignment: .top)
                .clipShape(Rectangle())
            
            RowView(maxHeight: maxHeight)
                .overlay(
                    LinearGradient(colors: [Color.black.opacity(0.4), Color.black.opacity(0.3)], startPoint: .bottomTrailing, endPoint: .topLeading)
                        .opacity((1.0 - (height / maxHeight)))
                )
                .rotation3DEffect(Angle(degrees: 90 * (1.0 - (height / maxHeight))), axis: (x: 1, y: 0, z: 0), anchor: .bottom)
                .frame(height: height * 0.5, alignment: .bottom)
                .clipShape(Rectangle())
        }
    }
}

struct P179_FoldUnfold_Previews: PreviewProvider {
    static var previews: some View {
        P179_FoldUnfold()
    }
}

