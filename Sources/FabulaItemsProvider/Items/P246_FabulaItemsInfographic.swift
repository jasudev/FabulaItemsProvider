//
//  P246_FabulaItemsInfographic.swift
//  
//
//  Created by jasu on 2022/05/14.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P246_FabulaItemsInfographic: View {
    
    let colors = [Color(hex: 0x9CCCE6), Color(hex: 0xebc090), Color(hex: 0xCB9A9F), Color(hex: 0xBDB2CE), Color(hex: 0x295A76), Color(hex: 0xDE8B91)]
#if os(iOS)
    let trailingPadding: CGFloat = 70
#else
    let trailingPadding: CGFloat = 120
#endif
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 4) {
                        content(proxy: proxy)
                    }
                }
                let y: CGFloat = CGFloat(ItemsProvider.shared.items.count) * 0.193
                
                let uiuxCount = ItemsProvider.shared.items.filter{$0.category == .uiux}.count
                let playCount = ItemsProvider.shared.items.filter{$0.category == .play}.count
                let studyCount = ItemsProvider.shared.items.filter{$0.category == .study}.count
                infoView(color: colors[0], title: "UIUX", count: uiuxCount, offset: CGPoint(x: proxy.size.width - trailingPadding, y: y))
                infoView(color: colors[1], title: "PLAY", count: playCount, offset: CGPoint(x: proxy.size.width - trailingPadding, y: y + 100))
                infoView(color: colors[2], title: "STUDY", count: studyCount, offset: CGPoint(x: proxy.size.width - trailingPadding, y: y + 200))
                
                let iOSCount = ItemsProvider.shared.items.filter{$0.platformType == .iOS}.count
                let macOSCount = ItemsProvider.shared.items.filter{$0.platformType == .macOS}.count
                let bothCount = ItemsProvider.shared.items.filter{$0.platformType == .both}.count
                infoView(color: colors[3], title: "both", count: bothCount, offset: CGPoint(x: proxy.size.width / 2, y: y + 50))
                infoView(color: colors[4], title: "iOS", count: iOSCount, offset: CGPoint(x: proxy.size.width / 2, y: y + 150))
                infoView(color: colors[5], title: "macOS", count: macOSCount, offset: CGPoint(x: proxy.size.width / 2, y: y + 250))
                
                ZStack(alignment: .bottomTrailing) {
                    Color.clear
                    Text("Fabula\n")
                        .font(.title2)
                        .foregroundColor(Color.fabulaPrimary)
                    + Text("Total ")
                        .font(.title2)
                    + Text("\(ItemsProvider.shared.items.count) ")
                        .font(.title2)
                        .foregroundColor(Color.fabulaPrimary)
                    + Text("items")
                        .font(.title2)
                }
                .padding([.bottom, .trailing], 24)
            }
        }
        .padding()
    }
    
    private func infoView(color: Color, title: String, count: Int, offset: CGPoint) -> some View {
        HStack(alignment: .top, spacing: 4) {
            Rectangle()
                .fill(color)
                .frame(width: 6)
            VStack {
                HStack {
                    Text(title)
                        .font(.caption2)
                        .bold()
                        .foregroundColor(Color.fabulaFore1)
                    Spacer()
                }
                HStack {
                    Text("\(count)")
                        .font(.caption2)
                        .foregroundColor(Color.fabulaPrimary)
                    Spacer()
                }
            }
            .padding(.top, 3)
            Spacer()
        }
        .frame(width: 70, height: CGFloat(ItemsProvider.shared.items.count) * 0.2)
        .background(
            ZStack {
                Color.fabulaBack1
                color.opacity(0.2)
            }
                .opacity(0.5)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke()
                        .fill(color.opacity(0.3))
                )
                
                
        )
        .offset(x: offset.x, y: offset.y)
    }
    
    private func content(proxy: GeometryProxy) -> some View {
        ForEach(ItemsProvider.shared.items) { item in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.fabulaPrimary)
                    .frame(width: 5)
                    .background(Color.fabulaBack1.opacity(0.5))
                Text(" - " + item.title)
                    .font(.caption2)
                    .padding(2)
                    .background(
                        LinearGradient(colors: [Color.fabulaBack1, Color.fabulaBack1.opacity(0)], startPoint: .leading, endPoint: .trailing)
                    )
                Spacer()
            }
            .frame(height: 10)
            .foregroundColor(Color.fabulaFore1)
            .background(
                GeometryReader { proxy2 in
                    ZStack {
                        if item.category == .uiux {
                            curveLine(endPoint: CGPoint(x: proxy.size.width - trailingPadding,
                                                        y: proxy.frame(in: .global).origin.y - (proxy2.frame(in: .global).origin.y) + 100 - CGFloat(item.id) * 0.18))
                            .foregroundColor(colors[0])
                        } else if item.category == .play {
                            curveLine(endPoint: CGPoint(x: proxy.size.width - trailingPadding,
                                                        y: proxy.frame(in: .global).origin.y - (proxy2.frame(in: .global).origin.y) + 200 - CGFloat(item.id) * 0.18))
                            .foregroundColor(colors[1])
                        } else {
                            curveLine(endPoint: CGPoint(x: proxy.size.width - trailingPadding,
                                                        y: proxy.frame(in: .global).origin.y - (proxy2.frame(in: .global).origin.y) + 300 - CGFloat(item.id) * 0.18))
                            .foregroundColor(colors[2])
                        }
                    }
                    ZStack {
                        if item.platformType == .both {
                            curveLine(endPoint: CGPoint(x: proxy.size.width / 2,
                                                        y: proxy.frame(in: .global).origin.y - (proxy2.frame(in: .global).origin.y) + 150 - CGFloat(item.id) * 0.18))
                            .foregroundColor(colors[3])
                        } else if item.platformType == .iOS {
                            curveLine(endPoint: CGPoint(x: proxy.size.width / 2,
                                                        y: proxy.frame(in: .global).origin.y - (proxy2.frame(in: .global).origin.y) + 250 - CGFloat(item.id) * 0.18))
                            .foregroundColor(colors[4])
                        } else {
                            curveLine(endPoint: CGPoint(x: proxy.size.width / 2,
                                                        y: proxy.frame(in: .global).origin.y - (proxy2.frame(in: .global).origin.y) + 350 - CGFloat(item.id) * 0.18))
                            .foregroundColor(colors[5])
                        }
                    }
                    .frame(width: proxy.size.width / 2)
                }
                    .opacity(0.3)
            )
        }
    }
    
    private func curveLine(endPoint: CGPoint) -> some View {
        VerticalCurveLine(startPoint: CGPoint(x: 0, y: 4), endPoint: endPoint, lineWidth: 1)
    }
}

struct P246_FabulaItemsInfographic_Previews: PreviewProvider {
    static var previews: some View {
        P246_FabulaItemsInfographic()
            .preferredColorScheme(.dark)
    }
}

fileprivate
struct VerticalCurveLine: View {
    let startPoint: CGPoint
    let endPoint: CGPoint
    let lineWidth: CGFloat
    var body: some View {
        GeometryReader { proxy in
            CurveLine(startPoint: startPoint,
                      control1: CGPoint(x: proxy.size.width * 0.5, y: startPoint.y),
                      control2: CGPoint(x: proxy.size.width * 0.5, y: endPoint.y),
                      endPoint: endPoint)
            .stroke(lineWidth: lineWidth)
        }
    }
    
    struct CurveLine: Shape {
        
        var startPoint: CGPoint
        var control1: CGPoint
        var control2: CGPoint
        var endPoint: CGPoint
        
        var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
            get { AnimatablePair(startPoint.animatableData, endPoint.animatableData) }
            set { (startPoint.animatableData, endPoint.animatableData) = (newValue.first, newValue.second) }
        }
        
        func path(in rect: CGRect) -> Path {
            var p = Path()
            
            p.move(to: startPoint)
            p.addCurve(to: endPoint, control1: control1, control2: control2)
            
            return p
        }
    }
}
