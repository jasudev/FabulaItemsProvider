//
//  P7_GuideLineModifier.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P7_GuideLineModifier: View {
    
    let spacing: CGFloat = 30
    
    public init() {}
    public var body: some View {
        HStack(spacing: spacing) {
            VStack(spacing: spacing) {
                getCapsuleView("1")
                getCapsuleView("2")
            }
            HStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    getCapsuleView("3")
                    getCapsuleView("4")
                }
                getCapsuleView("5")
            }
        }
        .padding(.vertical, spacing * 3)
        .padding(.horizontal, spacing)
    }
    
    private func getCapsuleView(_ text: String) -> some View {
        Capsule()
            .strokeBorder(Color.fabulaSecondary, lineWidth: 1.5, antialiased: true)
            .overlay(
                Text(text)
                    .font(.callout)
                    .foregroundColor(Color.fabulaPrimary)
            )
            .modifier(GuideLineModifier(direction: .height(.trailing)))
            .modifier(GuideLineModifier(direction: .width(.bottom)))
    }
}

extension P7_GuideLineModifier {
    enum GuideLineDirection {
        case width(VerticalAlignment)
        case height(HorizontalAlignment)
    }
    
    enum GuideLinePosition {
        case inside
        case outside
    }
    
    struct GuideLineModifier: ViewModifier {
        
        var direction: GuideLineDirection = .height(.trailing)
        var position: GuideLinePosition = .outside
        var color: Color = Color.fabulaFore2
        var textForegroundColor: Color = Color.fabulaFore1
        var textBackgroundColor: Color = Color.fabulaBack1
        var space: CGFloat = 20
        
        let min: CGFloat = 1
        let max: CGFloat = 7
        let spacing: CGFloat = 3
        
        func body(content: Content) -> some View {
            ZStack {
                content
                GeometryReader { proxy in
                    ZStack {
                        switch direction {
                        case .width(let align):
                            HStack(alignment: .center, spacing: spacing) {
                                Rectangle()
                                    .frame(width: min, height: max)
                                Rectangle()
                                    .frame(height: min, alignment: .center)
                                getText(proxy.size.width)
                                Rectangle()
                                    .frame(height: min, alignment: .center)
                                Rectangle()
                                    .frame(width: min, height: max)
                            }
                            .frame(height: space)
                            .offset(x: 0, y: getYWidth(proxy, align: align))
                        case .height(let align):
                            VStack(alignment: .center, spacing: spacing) {
                                Rectangle()
                                    .frame(width: max, height: min)
                                Rectangle()
                                    .frame(width: min, alignment: .center)
                                getText(proxy.size.height)
                                Rectangle()
                                    .frame(width: min, alignment: .center)
                                Rectangle()
                                    .frame(width: max, height: min)
                            }
                            .frame(width: space)
                            .offset(x: getXHeight(proxy, align: align), y: 0)
                        }
                    }
                    .foregroundColor(color)
                }
            }
        }
        
        private func getText(_ value: CGFloat) -> some View {
            Text(String(format: "%.1f", value))
                .font(.caption)
                .foregroundColor(textForegroundColor)
                .fixedSize()
                .padding(.horizontal, 4)
                .background(textBackgroundColor)
                .clipShape(Capsule())
        }
        
        private func getYWidth(_ proxy: GeometryProxy, align: VerticalAlignment) -> CGFloat {
            if align == .bottom {
                return position == .outside ? proxy.size.height : proxy.size.height - space
            }else {
                return position == .outside ? -space : 0
            }
        }
        
        private func getXHeight(_ proxy: GeometryProxy, align: HorizontalAlignment) -> CGFloat {
            if align == .trailing {
                return position == .outside ? proxy.size.width : proxy.size.width - space
            }else {
                return position == .outside ? -space : 0
            }
        }
    }
}

struct P7_GuideLineModifier_Previews: PreviewProvider {
    static var previews: some View {
        P7_GuideLineModifier()
    }
}
