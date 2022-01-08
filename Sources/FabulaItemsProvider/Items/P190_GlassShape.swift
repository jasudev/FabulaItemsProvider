//
//  P190_GlassShape.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P190_GlassShape: View {
    
    @State private var location: CGPoint = .zero
    @State var isDragging = false
    
    private var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.location = value.location
                self.isDragging = true
            }
            .onEnded {_ in self.isDragging = false}
    }
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                GlassBackground()
                ZStack {
                    CardView()
                        .overlay(
                            CardOverlayView()
                        )
                        .cornerRadius(16)
                }
                .position(location)
                .animation(.easeOut, value: location)
                .gesture(drag)
                
            }
            .onAppear {
                location = CGPoint(x: proxy.size.width * 0.5, y: proxy.size.height * 0.5)
            }
        }
    }
}

fileprivate
struct GlassBackground: View {
    var body: some View {
        GeometryReader { proxy in
            Circle()
                .fill(LinearGradient(colors: [Color(hex: 0xE9E1C1),
                                              Color(hex: 0xD7C47F)],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .frame(width: 160, height: 160)
                .position(x: proxy.size.width * 0.3, y: proxy.size.height * 0.65)
            
            Circle()
                .fill(LinearGradient(colors: [Color(hex: 0x62CBF0),
                                              Color(hex: 0x3F8DED)],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .frame(width: 280, height: 280)
                .position(x: proxy.size.width * 0.6, y: proxy.size.height * 0.4)
            
            Circle()
                .fill(LinearGradient(colors: [Color(hex: 0xAD4484),
                                              Color(hex: 0xDA6352)],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .frame(width: 100, height: 100)
                .position(x: proxy.size.width * 0.7, y: proxy.size.height * 0.65)
        }
        .background(LinearGradient(colors: [Color(hex: 0x000000),
                                            Color(hex: 0x2D6ABC)],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
    }
}

fileprivate
struct CardView: View {
    var body: some View {
        if #available(macOS 12.0, *) {
            Rectangle()
                .fill(Color.clear)
                .frame(width: 300, height: 200)
                .background(.ultraThinMaterial)
        } else {
            Rectangle()
                .fill(Color.clear)
                .frame(width: 300, height: 200)
                .background(Color.white.opacity(0.6))
        }
    }
}

fileprivate
struct CardOverlayView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(LinearGradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0), Color.white.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                VStack(alignment: .leading) {
                    Image(systemName: "person.crop.square")
                        .font(.largeTitle)
                    Spacer()
                    Spacer()
                    Text("3848   2234   5424   1058")
                        .font(.custom("Tamil Sangam MN", size: 20))
                        .fontWeight(.semibold)
                    Text("FABULA")
                        .font(.system(size: 10))
                        .padding(.top, 10)
                    Spacer()
                }
                .foregroundColor(Color.white.opacity(0.5))
                Spacer()
            }
        }
    }
}

struct P190_GlassShape_Previews: PreviewProvider {
    static var previews: some View {
        P190_GlassShape()
    }
}
