//
//  P176_TabSegmentedView.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P176_TabSegmentedView: View {
    
    @State private var isScrollable: Bool = true
    @State private var index: Int = 0
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading) {
            if #available(macOS 12.0, *) {
                Toggle("isScrollable", isOn: $isScrollable.animation())
                    .tint(Color.fabulaPrimary)
            } else {
                Toggle("isScrollable", isOn: $isScrollable.animation())
            }
            Divider().padding()
            TabSegmentedView(index: $index, spacingSize: CGSize(width: 23, height: 8), isScrollable: isScrollable, items: [
                TabSegmentItem(
                    top: Text("Menu 1")
                        .bold()
                        .foregroundColor(index == 0 ? Color.red : Color.gray),
                    indicator: Capsule().fill(Color.red).frame(height: 2),
                    bottom: ZStack {
                        Rectangle().opacity(0.1)
                        Text("Content 1")
                    }
                        .foregroundColor(Color.red)
                ),
                TabSegmentItem(
                    top: Text("Menu 2")
                        .bold()
                        .foregroundColor(index == 1 ? Color.green : Color.gray),
                    indicator: Capsule().fill(Color.green).frame(height: 2),
                    bottom: ZStack {
                        Rectangle().opacity(0.1)
                        Text("Content 2")
                    }
                        .foregroundColor(Color.green)
                ),
                TabSegmentItem(
                    top: Text("Menu 3")
                        .bold()
                        .foregroundColor(index == 2 ? Color.blue : Color.gray),
                    indicator: Capsule().fill(Color.blue).frame(height: 2),
                    bottom: ZStack {
                        Rectangle().opacity(0.1)
                        Text("Content 3")
                    }
                        .foregroundColor(Color.blue)
                )
            ])
        }
        .padding()
    }
}

fileprivate
extension P176_TabSegmentedView {
    
    struct TabSegmentItem<TopMenu: View, Indicator: View, BottomContent: View>: Identifiable {
        var id = UUID()
        var top: TopMenu
        var indicator: Indicator
        var bottom: BottomContent
    }
    
    struct TabSegmentedView<TopMenu: View, Indicator: View, BottomContent: View>: View {
        @Namespace private var namespace
        
        @Binding var index: Int
        var spacingSize: CGSize
        var isScrollable: Bool
        let items: [TabSegmentItem<TopMenu, Indicator, BottomContent>]
        @GestureState private var dragAmount: CGSize = .zero
        
        private var topView: some View {
            HStack(spacing: spacingSize.width) {
                ForEach(items.indices) { index in
                    if !isScrollable && index != 0 {
                        Spacer()
                    }
                    VStack(spacing: spacingSize.height) {
                        items[index].top
                            .onTapGesture {
                                self.index = index
                            }
                        if self.index == index {
                            items[index].indicator
                                .matchedGeometryEffect(id: "indicator", in: namespace)
                        }
                    }
                    .fixedSize()
                }
            }
            .animation(.easeInOut, value: self.index)
        }
        
        private var bottomView: some View {
#if os(iOS)
            TabView(selection: $index) {
                ForEach(items.indices) { index in
                    items[index].bottom
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .animation(.easeInOut, value: self.index)
#else
            GeometryReader { proxy in
                let size = proxy.size
                HStack(spacing: 0) {
                    ForEach(items.indices) { index in
                        items[index].bottom
                    }
                    .frame(width: size.width)
                }
                .offset(x: dragAmount.width)
                .offset(x: -(CGFloat(self.index) * size.width))
                .gesture(
                    DragGesture()
                        .updating($dragAmount) { value, state, transaction in
                            state = value.translation
                        }.onEnded { value in
                            let x = (value.translation.width) / size.width
                            let nextIndex = (CGFloat(self.index) - x * 2.5).rounded()
                            self.index = min(max(Int(nextIndex), 0), items.count - 1)
                        }
                )
            }
            .clipShape(Rectangle())
            .animation(.easeInOut, value: dragAmount)
            .animation(.easeInOut, value: index)
#endif
        }

        var body: some View {
            VStack(alignment: .leading) {
                if isScrollable {
                    ScrollView(.horizontal, showsIndicators: false) {
                        topView
                    }
                }else {
                    topView
                }
                bottomView
            }
        }
    }
}

struct P176_TabSegmentedView_Previews: PreviewProvider {
    static var previews: some View {
        P176_TabSegmentedView()
    }
}
