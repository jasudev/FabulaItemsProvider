//
//  P233_AxisTabView.swift
//  
//  Package : https://github.com/jasudev/AxisTabView.git
//  Created by jasu on 2022/03/13.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisTabView

public struct P233_AxisTabView: View {
    
    var content: some View {
        List {
            Section {
                NavigationLink("BasicStyle") { BasicPreview()}
                NavigationLink("CapsuleStyle") { CapsulePreview()}
                NavigationLink("MaterialStyle") { MaterialPreview()}
            } header: {
                Text("Normal")
            }
            
            Section {
                NavigationLink("Concave") { CurveConcavePreview()}
                NavigationLink("Convex") { CurveConvexPreview()}
            } header: {
                Text("CurveStyle")
            }
            
            Section {
                NavigationLink("Center") { CenterPreview()}
                NavigationLink("Line") { LinePreview()}
            } header: {
                Text("Custom")
            }
        }
        .navigationTitle(Text("AxisTabView"))
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
    public init() {}
    public var body: some View {
        #if os(iOS)
        content
        #else
        NavigationView {
            content
        }
        #endif
    }
}

fileprivate
struct CustomCenterStyle: ATBackgroundStyle {
    
    var state: ATTabState
    var color: Color = .white
    var radius: CGFloat = 80
    var depth: CGFloat = 0.8
    
    init(_ state: ATTabState, color: Color, radius: CGFloat, depth: CGFloat) {
        self.state = state
        self.color = color
        self.radius = radius
        self.depth = depth
    }
    
    var body: some View {
        let tabConstant = state.constant.tab
        GeometryReader { proxy in
            ATCurveShape(radius: radius, depth: depth, position: 0.5)
                .fill(color)
                .frame(height: tabConstant.normalSize.height + (state.constant.axisMode == .bottom ? state.safeAreaInsets.bottom : state.safeAreaInsets.top))
                .scaleEffect(CGSize(width: 1, height: state.constant.axisMode == .bottom ? 1 : -1))
                .mask(
                    Rectangle()
                        .frame(height: proxy.size.height + 100)
                )
                .shadow(color: tabConstant.shadow.color,
                        radius: tabConstant.shadow.radius,
                        x: tabConstant.shadow.x,
                        y: tabConstant.shadow.y)
        }
        .animation(.easeInOut, value: state.currentIndex)
    }
}

fileprivate
struct CustomLineStyle: ATBackgroundStyle {
    
    var state: ATTabState
    var color: Color
    var lineColor: Color
    
    init(_ state: ATTabState = .init(), color: Color = .white, lineColor: Color = .accentColor) {
        self.state = state
        self.color = color
        self.lineColor = lineColor
    }
    
    var body: some View {
        let tabConstant = state.constant.tab
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(color)
                .shadow(color: tabConstant.shadow.color,
                        radius: tabConstant.shadow.radius,
                        x: tabConstant.shadow.x,
                        y: tabConstant.shadow.y)
            
            VStack(spacing: 0) {
                if state.constant.axisMode == .bottom {
                    Spacer()
                        .frame(height: tabConstant.normalSize.height)
                }
                Capsule()
                    .foregroundColor(lineColor)
                    .frame(width: tabConstant.selectWidth > 0 ? tabConstant.selectWidth : tabConstant.normalSize.width, height: 2)
                    .offset(x: state.getCurrentX(), y: state.constant.axisMode == .bottom ? -6 : state.safeAreaInsets.top + tabConstant.normalSize.height - 6)
                    .animation(state.constant.tab.animation ?? .none, value: state.currentIndex)
                
                if state.constant.axisMode == .top {
                    Spacer()
                        .frame(height: tabConstant.normalSize.height)
                }
            }
        }
    }
}

fileprivate
struct BasicPreview: View {

    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init(selectWidth: 140))
    @State private var color: Color = .blue
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                ATBasicStyle(state, color: color)
            } content: {
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 0, systemName: "01.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 1, systemName: "02.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 2, systemName: "03.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 3, systemName: "04.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 4, systemName: "05.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 5, systemName: "06.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
            }
        }
        .animation(.easeInOut, value: constant)
        .navigationTitle("Screen \(selection + 1)")
    }
    
    struct ControllView: View {

        @Binding var selection: Int
        @Binding var constant: ATConstant
        @Binding var color: Color
        
        let tag: Int
        let systemName: String
        let safeAreaTop: CGFloat
        
        private var backgroundColor: Color {
            let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
            guard selection <= colors.count - 1 else { return Color(hex: 0x295A76)}
            return colors[selection].opacity(0.2)
        }
        
        private var content: some View {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("● AxisMode").opacity(0.5)
                    Picker(selection: $constant.axisMode) {
                        Text("Top")
                            .tag(ATAxisMode.top)
                        Text("Bottom")
                            .tag(ATAxisMode.bottom)
                    } label: {
                        Text("AxisMode")
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Screen Transition").opacity(0.5)
                    Picker(selection: $constant.screen.transitionMode) {
                        Text("Slide")
                            .tag(ATTransitionMode.slide(50))
                        Text("Opacity")
                            .tag(ATTransitionMode.opacity)
                        Text("Scale")
                            .tag(ATTransitionMode.scale(0.90))
                        Text("None")
                            .tag(ATTransitionMode.none)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                    Toggle(isOn: $constant.screen.activeSafeArea) {
                        Text("SafeArea Toggle")
                    }
                    .padding(.horizontal)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Normal Size").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.width, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.width, specifier: "%.2f")")
                    }
                    .padding(.leading)
                    HStack {
                        Text("H").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.height, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.height, specifier: "%.2f")")
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Select Width").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.selectWidth, in: -1...200)
                        Spacer()
                        Text("\(constant.tab.selectWidth, specifier: "%.2f")")
                        
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Spacing").opacity(0.5)
                    Picker(selection: $constant.tab.spacingMode) {
                        Text("Center")
                            .tag(ATSpacingMode.center)
                        Text("Average")
                            .tag(ATSpacingMode.average)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading)
                    HStack {
                        Text("Spacing")
                        Spacer()
                        Slider(value: $constant.tab.spacing, in: 0...30)
                        Spacer()
                        Text("\(constant.tab.spacing, specifier: "%.2f")")
                    }
                    .disabled(constant.tab.spacingMode == .average)
                    .opacity(constant.tab.spacingMode == .average ? 0.5 : 1.0)
                    .padding(.leading)
                    
                    HStack {
                        Text("Color")
                        Spacer()
                        ColorPicker("", selection: $color)
                    }
                    .padding(.leading)
                    .labelsHidden()
                }
            }
        }
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                if constant.axisMode == .bottom {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }else {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }
            }
            .tabItem(tag: tag, normal: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName)
            }, select: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName)
            })
        }
        
        private func getTopPadding() -> CGFloat {
            guard !constant.screen.activeSafeArea else { return 0 }
            return constant.axisMode == .top ? constant.tab.normalSize.height + safeAreaTop : 0
        }
    }

    struct TabButton: View {
        
        @Binding var constant: ATConstant
        @Binding var selection: Int
        
        let tag: Int
        let isSelection: Bool
        let systemName: String

        @State private var w: CGFloat = 0
        
        var content: some View {
            HStack(spacing: 0) {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 24))
                    .padding(10)
                if isSelection {
                    Text(systemName)
                        .lineLimit(1)
                }
            }
            .frame(width: w, height: constant.tab.normalSize.height * 0.85, alignment: .leading)
            .foregroundColor(isSelection ? Color.white : Color.black)
            .background(isSelection ? Color.accentColor : Color.clear)
            .clipShape(Capsule())
            .onAppear {
                w = constant.tab.normalSize.width
                if isSelection {
                    withAnimation(.easeInOut(duration: 0.26)) {
                        w = constant.tab.selectWidth < 0 ? constant.tab.normalSize.width : constant.tab.selectWidth + 5
                    }
                    withAnimation(.easeInOut(duration: 0.3).delay(0.25)) {
                        w = constant.tab.selectWidth < 0 ? constant.tab.normalSize.width : constant.tab.selectWidth
                    }
                }else {
                    w = constant.tab.normalSize.width
                }
            }
        }
        var body: some View {
            if constant.axisMode == .top {
                content
            }else {
                content
            }
        }
    }
}

fileprivate
struct CurveConcavePreview: View {

    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
    @State private var radius: CGFloat = 60
    @State private var concaveDepth: CGFloat = 0.90
    @State private var color: Color = .white
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                ATCurveStyle(state, color: color, radius: radius, depth: concaveDepth)
            } content: {
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 0, systemName: "01.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 1, systemName: "02.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 2, systemName: "03.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 3, systemName: "04.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 4, systemName: "05.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 5, systemName: "06.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
            }
        }
        .animation(.easeInOut, value: constant)
        .animation(.easeInOut, value: radius)
        .animation(.easeInOut, value: concaveDepth)
        .navigationTitle("Screen \(selection + 1)")
    }
    
    struct ControllView: View {

        @Binding var selection: Int
        @Binding var constant: ATConstant
        @Binding var radius: CGFloat
        @Binding var concaveDepth: CGFloat
        @Binding var color: Color
        
        let tag: Int
        let systemName: String
        let safeAreaTop: CGFloat
        
        private var backgroundColor: Color {
            let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
            guard selection <= colors.count - 1 else { return Color(hex: 0x295A76)}
            return colors[selection].opacity(0.2)
        }
        
        private var content: some View {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("● AxisMode").opacity(0.5)
                    Picker(selection: $constant.axisMode) {
                        Text("Top")
                            .tag(ATAxisMode.top)
                        Text("Bottom")
                            .tag(ATAxisMode.bottom)
                    } label: {
                        Text("AxisMode")
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Screen Transition").opacity(0.5)
                    Picker(selection: $constant.screen.transitionMode) {
                        Text("Slide")
                            .tag(ATTransitionMode.slide(50))
                        Text("Opacity")
                            .tag(ATTransitionMode.opacity)
                        Text("Scale")
                            .tag(ATTransitionMode.scale(0.90))
                        Text("None")
                            .tag(ATTransitionMode.none)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                    Toggle(isOn: $constant.screen.activeSafeArea) {
                        Text("SafeArea Toggle")
                    }
                    .padding(.horizontal)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Normal Size").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.width, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.width, specifier: "%.2f")")
                    }
                    .padding(.leading)
                    HStack {
                        Text("H").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.height, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.height, specifier: "%.2f")")
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Select Width").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.selectWidth, in: -1...200)
                        Spacer()
                        Text("\(constant.tab.selectWidth, specifier: "%.2f")")
                        
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Spacing").opacity(0.5)
                    Picker(selection: $constant.tab.spacingMode) {
                        Text("Center")
                            .tag(ATSpacingMode.center)
                        Text("Average")
                            .tag(ATSpacingMode.average)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading)
                    HStack {
                        Text("Spacing")
                        Spacer()
                        Slider(value: $constant.tab.spacing, in: 0...30)
                        Spacer()
                        Text("\(constant.tab.spacing, specifier: "%.2f")")
                    }
                    .disabled(constant.tab.spacingMode == .average)
                    .opacity(constant.tab.spacingMode == .average ? 0.5 : 1.0)
                    .padding(.leading)
                    
                    HStack {
                        Text("Color")
                        Spacer()
                        ColorPicker("", selection: $color)
                    }
                    .padding(.leading)
                    .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Background CurveStyle").opacity(0.5)
                    HStack {
                        Text("Radius")
                        Spacer()
                        Slider(value: $radius, in: 0...100)
                        Spacer()
                        Text("\(radius, specifier: "%.2f")")
                    }
                    .labelsHidden()
                    .padding(.leading)

                    HStack {
                        Text("Concave Depth")
                        Spacer()
                        Slider(value: $concaveDepth, in: 0...0.9)
                        Spacer()
                        Text("\(concaveDepth, specifier: "%.2f")")
                    }
                    .labelsHidden()
                    .padding(.leading)
                }
                
            }
        }
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                if constant.axisMode == .bottom {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }else {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }
            }
            .tabItem(tag: tag, normal: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName)
            }, select: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName)
            })
        }
        
        private func getTopPadding() -> CGFloat {
            guard !constant.screen.activeSafeArea else { return 0 }
            return constant.axisMode == .top ? constant.tab.normalSize.height + safeAreaTop : 0
        }
    }

    struct TabButton: View {
        
        @Binding var constant: ATConstant
        @Binding var selection: Int
        
        let tag: Int
        let isSelection: Bool
        let systemName: String
        
        @State private var y: CGFloat = 0

        var content: some View {
            ZStack(alignment: .leading) {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 24))
                    .padding(10)
            }
            .foregroundColor(isSelection ? Color.white : Color.black)
            .background(isSelection ? Color.red : Color.clear)
            .clipShape(Capsule())
            .offset(y: y)
            .onAppear {
                if isSelection {
                    withAnimation(.easeInOut(duration: 0.26)) {
                        y = constant.axisMode == .top ? 22 : -22
                    }
                    withAnimation(.easeInOut(duration: 0.3).delay(0.25)) {
                        y = constant.axisMode == .top ? 17 : -17
                    }
                }else {
                    y = 0
                }
            }
        }
        var body: some View {
            if constant.axisMode == .top {
                content
            }else {
                content
            }
        }
    }
}

fileprivate
struct CurveConvexPreview: View {

    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
    @State private var radius: CGFloat = 60
    @State private var convexDepth: CGFloat = -0.65
    @State private var color: Color = .white
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                ATCurveStyle(state, color: color, radius: radius, depth: convexDepth)
            } content: {
                ControllView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 0, systemName: "01.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 1, systemName: "02.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 2, systemName: "03.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 3, systemName: "04.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 4, systemName: "05.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 5, systemName: "06.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
            }
        }
        .animation(.easeInOut, value: constant)
        .animation(.easeInOut, value: radius)
        .animation(.easeInOut, value: convexDepth)
        .navigationTitle("Screen \(selection + 1)")
    }
    
    struct ControllView: View {

        @Binding var selection: Int
        @Binding var constant: ATConstant
        @Binding var radius: CGFloat
        @Binding var convexDepth: CGFloat
        @Binding var color: Color
        
        let tag: Int
        let systemName: String
        let safeAreaTop: CGFloat
        
        private var backgroundColor: Color {
            let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
            guard selection <= colors.count - 1 else { return Color(hex: 0x295A76)}
            return colors[selection].opacity(0.2)
        }
        
        private var content: some View {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("● AxisMode").opacity(0.5)
                    Picker(selection: $constant.axisMode) {
                        Text("Top")
                            .tag(ATAxisMode.top)
                        Text("Bottom")
                            .tag(ATAxisMode.bottom)
                    } label: {
                        Text("AxisMode")
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Screen Transition").opacity(0.5)
                    Picker(selection: $constant.screen.transitionMode) {
                        Text("Slide")
                            .tag(ATTransitionMode.slide(50))
                        Text("Opacity")
                            .tag(ATTransitionMode.opacity)
                        Text("Scale")
                            .tag(ATTransitionMode.scale(0.90))
                        Text("None")
                            .tag(ATTransitionMode.none)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                    Toggle(isOn: $constant.screen.activeSafeArea) {
                        Text("SafeArea Toggle")
                    }
                    .padding(.horizontal)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Normal Size").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.width, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.width, specifier: "%.2f")")
                    }
                    .padding(.leading)
                    HStack {
                        Text("H").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.height, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.height, specifier: "%.2f")")
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Select Width").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.selectWidth, in: -1...200)
                        Spacer()
                        Text("\(constant.tab.selectWidth, specifier: "%.2f")")
                        
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Spacing").opacity(0.5)
                    Picker(selection: $constant.tab.spacingMode) {
                        Text("Center")
                            .tag(ATSpacingMode.center)
                        Text("Average")
                            .tag(ATSpacingMode.average)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading)
                    HStack {
                        Text("Spacing")
                        Spacer()
                        Slider(value: $constant.tab.spacing, in: 0...30)
                        Spacer()
                        Text("\(constant.tab.spacing, specifier: "%.2f")")
                    }
                    .disabled(constant.tab.spacingMode == .average)
                    .opacity(constant.tab.spacingMode == .average ? 0.5 : 1.0)
                    .padding(.leading)
                    
                    HStack {
                        Text("Color")
                        Spacer()
                        ColorPicker("", selection: $color)
                    }
                    .padding(.leading)
                    .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Background CurveStyle").opacity(0.5)
                    HStack {
                        Text("Radius")
                        Spacer()
                        Slider(value: $radius, in: 0...100)
                        Spacer()
                        Text("\(radius, specifier: "%.2f")")
                    }
                    .labelsHidden()
                    .padding(.leading)

                    HStack {
                        Text("Convex Depth")
                        Spacer()
                        Slider(value: $convexDepth, in: -0.65...0)
                        Spacer()
                        Text("\(convexDepth, specifier: "%.2f")")
                    }
                    .labelsHidden()
                    .padding(.leading)
                }
            }
        }
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                if constant.axisMode == .bottom {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }else {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }
            }
            .tabItem(tag: tag, normal: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName)
            }, select: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName)
            })
        }
        
        private func getTopPadding() -> CGFloat {
            guard !constant.screen.activeSafeArea else { return 0 }
            return constant.axisMode == .top ? constant.tab.normalSize.height + safeAreaTop : 0
        }
    }

    struct TabButton: View {
        
        @Binding var constant: ATConstant
        @Binding var selection: Int
        
        let tag: Int
        let isSelection: Bool
        let systemName: String
        
        @State private var y: CGFloat = 0
        
        var content: some View {
            ZStack(alignment: .leading) {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 24))
                    .padding(10)
            }
            .foregroundColor(isSelection ? Color.white : Color.black)
            .background(isSelection ? Color.red : Color.clear)
            .clipShape(Capsule())
            .offset(y: y)
            .onAppear {
                if isSelection {
                    withAnimation(.easeInOut(duration: 0.26)) {
                        y = constant.axisMode == .top ? 22 : -22
                    }
                    withAnimation(.easeInOut(duration: 0.3).delay(0.25)) {
                        y = constant.axisMode == .top ? 17 : -17
                    }
                }else {
                    y = 0
                }
            }
        }
        var body: some View {
            if constant.axisMode == .top {
                content
            }else {
                content
            }
        }
    }
}

fileprivate
struct CapsulePreview: View {

    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init(selectWidth: 140))
    @State private var color: Color = .blue
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                ATCapsuleStyle(state, color: color)
            } content: {
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 0, systemName: "01.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 1, systemName: "02.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 2, systemName: "03.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 3, systemName: "04.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 4, systemName: "05.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 5, systemName: "06.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
            }
        }
        .animation(.easeInOut, value: constant)
        .navigationTitle("Screen \(selection + 1)")
    }
    
    struct ControllView: View {

        @Binding var selection: Int
        @Binding var constant: ATConstant
        @Binding var color: Color
        
        let tag: Int
        let systemName: String
        let safeAreaTop: CGFloat
        
        private var backgroundColor: Color {
            let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
            guard selection <= colors.count - 1 else { return Color(hex: 0x295A76)}
            return colors[selection].opacity(0.2)
        }
        
        private var content: some View {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("● AxisMode").opacity(0.5)
                    Picker(selection: $constant.axisMode) {
                        Text("Top")
                            .tag(ATAxisMode.top)
                        Text("Bottom")
                            .tag(ATAxisMode.bottom)
                    } label: {
                        Text("AxisMode")
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Screen Transition").opacity(0.5)
                    Picker(selection: $constant.screen.transitionMode) {
                        Text("Slide")
                            .tag(ATTransitionMode.slide(50))
                        Text("Opacity")
                            .tag(ATTransitionMode.opacity)
                        Text("Scale")
                            .tag(ATTransitionMode.scale(0.90))
                        Text("None")
                            .tag(ATTransitionMode.none)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                    Toggle(isOn: $constant.screen.activeSafeArea) {
                        Text("SafeArea Toggle")
                    }
                    .padding(.horizontal)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Normal Size").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.width, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.width, specifier: "%.2f")")
                    }
                    .padding(.leading)
                    HStack {
                        Text("H").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.height, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.height, specifier: "%.2f")")
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Select Width").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.selectWidth, in: -1...200)
                        Spacer()
                        Text("\(constant.tab.selectWidth, specifier: "%.2f")")
                        
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Spacing").opacity(0.5)
                    Picker(selection: $constant.tab.spacingMode) {
                        Text("Center")
                            .tag(ATSpacingMode.center)
                        Text("Average")
                            .tag(ATSpacingMode.average)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading)
                    HStack {
                        Text("Spacing")
                        Spacer()
                        Slider(value: $constant.tab.spacing, in: 0...30)
                        Spacer()
                        Text("\(constant.tab.spacing, specifier: "%.2f")")
                    }
                    .disabled(constant.tab.spacingMode == .average)
                    .opacity(constant.tab.spacingMode == .average ? 0.5 : 1.0)
                    .padding(.leading)
                    
                    HStack {
                        Text("Color")
                        Spacer()
                        ColorPicker("", selection: $color)
                    }
                    .padding(.leading)
                    .labelsHidden()
                }
            }
        }
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                if constant.axisMode == .bottom {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }else {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }
            }
            .tabItem(tag: tag, normal: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName)
            }, select: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName)
            })
        }
        
        private func getTopPadding() -> CGFloat {
            guard !constant.screen.activeSafeArea else { return 0 }
            return constant.axisMode == .top ? constant.tab.normalSize.height + safeAreaTop : 0
        }
    }

    struct TabButton: View {
        
        @Binding var constant: ATConstant
        @Binding var selection: Int
        
        let tag: Int
        let isSelection: Bool
        let systemName: String

        @State private var w: CGFloat = 0
        
        var content: some View {
            ZStack(alignment: .leading) {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 24))
                    .padding(10)
                    .frame(width: w, alignment: .leading)
            }
            .foregroundColor(isSelection ? Color.white : Color.black)
            .background(isSelection ? Color.red : Color.clear)
            .clipShape(Capsule())
            .onAppear {
                w = constant.tab.normalSize.width
                if isSelection {
                    withAnimation(.easeInOut(duration: 0.26)) {
                        w = constant.tab.selectWidth < 0 ? constant.tab.normalSize.width : constant.tab.selectWidth + 5
                    }
                    withAnimation(.easeInOut(duration: 0.3).delay(0.25)) {
                        w = constant.tab.selectWidth < 0 ? constant.tab.normalSize.width : constant.tab.selectWidth
                    }
                }else {
                    w = constant.tab.normalSize.width
                }
            }
        }
        var body: some View {
            if constant.axisMode == .top {
                content
            }else {
                content
            }
        }
    }
}

fileprivate
struct MaterialPreview: View {

    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init(selectWidth: 140))
    @State private var color: Color = .white
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                if #available(iOS 15.0, *) {
                    ATMaterialStyle(state)
                } else {
                    // Fallback on earlier versions
                }
            } content: {
                ControllView(selection: $selection, constant: $constant, tag: 0, systemName: "01.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, tag: 1, systemName: "02.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, tag: 2, systemName: "03.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, tag: 3, systemName: "04.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, tag: 4, systemName: "05.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, tag: 5, systemName: "06.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
            }
        }
        .animation(.easeInOut, value: constant)
        .navigationTitle("Screen \(selection + 1)")
    }
    
    struct ControllView: View {

        @Binding var selection: Int
        @Binding var constant: ATConstant
        
        let tag: Int
        let systemName: String
        let safeAreaTop: CGFloat
        
        private var backgroundColor: Color {
            let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
            guard selection <= colors.count - 1 else { return Color(hex: 0x295A76)}
            return colors[selection].opacity(0.2)
        }
        
        private var content: some View {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("● AxisMode").opacity(0.5)
                    Picker(selection: $constant.axisMode) {
                        Text("Top")
                            .tag(ATAxisMode.top)
                        Text("Bottom")
                            .tag(ATAxisMode.bottom)
                    } label: {
                        Text("AxisMode")
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Screen Transition").opacity(0.5)
                    Picker(selection: $constant.screen.transitionMode) {
                        Text("Slide")
                            .tag(ATTransitionMode.slide(50))
                        Text("Opacity")
                            .tag(ATTransitionMode.opacity)
                        Text("Scale")
                            .tag(ATTransitionMode.scale(0.90))
                        Text("None")
                            .tag(ATTransitionMode.none)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                    Toggle(isOn: $constant.screen.activeSafeArea) {
                        Text("SafeArea Toggle")
                    }
                    .padding(.horizontal)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Normal Size").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.width, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.width, specifier: "%.2f")")
                    }
                    .padding(.leading)
                    HStack {
                        Text("H").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.height, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.height, specifier: "%.2f")")
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Select Width").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.selectWidth, in: -1...200)
                        Spacer()
                        Text("\(constant.tab.selectWidth, specifier: "%.2f")")
                        
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Spacing").opacity(0.5)
                    Picker(selection: $constant.tab.spacingMode) {
                        Text("Center")
                            .tag(ATSpacingMode.center)
                        Text("Average")
                            .tag(ATSpacingMode.average)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading)
                    HStack {
                        Text("Spacing")
                        Spacer()
                        Slider(value: $constant.tab.spacing, in: 0...30)
                        Spacer()
                        Text("\(constant.tab.spacing, specifier: "%.2f")")
                    }
                    .disabled(constant.tab.spacingMode == .average)
                    .opacity(constant.tab.spacingMode == .average ? 0.5 : 1.0)
                    .padding(.leading)
                }
            }
        }
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                if constant.axisMode == .bottom {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }else {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }
            }
            .tabItem(tag: tag, normal: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName)
            }, select: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName)
            })
        }
        
        private func getTopPadding() -> CGFloat {
            guard !constant.screen.activeSafeArea else { return 0 }
            return constant.axisMode == .top ? constant.tab.normalSize.height + safeAreaTop : 0
        }
    }

    struct TabButton: View {
        
        @Binding var constant: ATConstant
        @Binding var selection: Int
        
        let tag: Int
        let isSelection: Bool
        let systemName: String

        @State private var w: CGFloat = 0
        
        var content: some View {
            HStack(spacing: 0) {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 24))
                    .padding(10)
                if isSelection {
                    Text(systemName)
                        .lineLimit(1)
                }
            }
            .frame(width: w, height: constant.tab.normalSize.height * 0.85, alignment: .leading)
            .foregroundColor(isSelection ? Color.white : Color.black)
            .background(isSelection ? Color.accentColor : Color.clear)
            .clipShape(Capsule())
            .onAppear {
                w = constant.tab.normalSize.width
                if isSelection {
                    withAnimation(.easeInOut(duration: 0.26)) {
                        w = constant.tab.selectWidth < 0 ? constant.tab.normalSize.width : constant.tab.selectWidth + 5
                    }
                    withAnimation(.easeInOut(duration: 0.3).delay(0.25)) {
                        w = constant.tab.selectWidth < 0 ? constant.tab.normalSize.width : constant.tab.selectWidth
                    }
                }else {
                    w = constant.tab.normalSize.width
                }
            }
        }
        var body: some View {
            if constant.axisMode == .top {
                content
            }else {
                content
            }
        }
    }
}

fileprivate
struct CenterPreview: View {

    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
    @State private var radius: CGFloat = 70
    @State private var concaveDepth: CGFloat = 0.85
    @State private var color: Color = .white
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                CustomCenterStyle(state, color: color, radius: radius, depth: concaveDepth)
            } content: {
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 0, systemName: "01.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 1, systemName: "02.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 2, systemName: "plus.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 3, systemName: "04.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 4, systemName: "05.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
            }
        }
        .animation(.easeInOut, value: constant)
        .animation(.easeInOut, value: radius)
        .animation(.easeInOut, value: concaveDepth)
        .navigationTitle("Screen \(selection + 1)")
    }
    
    struct ControllView: View {

        @Binding var selection: Int
        @Binding var constant: ATConstant
        @Binding var radius: CGFloat
        @Binding var concaveDepth: CGFloat
        @Binding var color: Color
        
        let tag: Int
        let systemName: String
        let safeAreaTop: CGFloat
        
        private var backgroundColor: Color {
            let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
            guard selection <= colors.count - 1 else { return Color(hex: 0x295A76)}
            return colors[selection].opacity(0.2)
        }
        
        private var content: some View {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("● AxisMode").opacity(0.5)
                    Picker(selection: $constant.axisMode) {
                        Text("Top")
                            .tag(ATAxisMode.top)
                        Text("Bottom")
                            .tag(ATAxisMode.bottom)
                    } label: {
                        Text("AxisMode")
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Screen Transition").opacity(0.5)
                    Picker(selection: $constant.screen.transitionMode) {
                        Text("Slide")
                            .tag(ATTransitionMode.slide(50))
                        Text("Opacity")
                            .tag(ATTransitionMode.opacity)
                        Text("Scale")
                            .tag(ATTransitionMode.scale(0.90))
                        Text("None")
                            .tag(ATTransitionMode.none)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                    Toggle(isOn: $constant.screen.activeSafeArea) {
                        Text("SafeArea Toggle")
                    }
                    .padding(.horizontal)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Spacing").opacity(0.5)
                    Picker(selection: $constant.tab.spacingMode) {
                        Text("Center")
                            .tag(ATSpacingMode.center)
                        Text("Average")
                            .tag(ATSpacingMode.average)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading)
                    HStack {
                        Text("Spacing")
                        Spacer()
                        Slider(value: $constant.tab.spacing, in: 0...30)
                        Spacer()
                        Text("\(constant.tab.spacing, specifier: "%.2f")")
                    }
                    .disabled(constant.tab.spacingMode == .average)
                    .opacity(constant.tab.spacingMode == .average ? 0.5 : 1.0)
                    .padding(.leading)
                    
                    HStack {
                        Text("Color")
                        Spacer()
                        ColorPicker("", selection: $color)
                    }
                    .padding(.leading)
                    .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Background CurveStyle").opacity(0.5)
                    HStack {
                        Text("Radius")
                        Spacer()
                        Slider(value: $radius, in: 0...100)
                        Spacer()
                        Text("\(radius, specifier: "%.2f")")
                    }
                    .labelsHidden()
                    .padding(.leading)

                    HStack {
                        Text("Concave Depth")
                        Spacer()
                        Slider(value: $concaveDepth, in: 0...0.9)
                        Spacer()
                        Text("\(concaveDepth, specifier: "%.2f")")
                    }
                    .labelsHidden()
                    .padding(.leading)
                }
                
            }
        }
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                if constant.axisMode == .bottom {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }else {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }
            }
            .tabItem(tag: tag, normal: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName)
            }, select: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName)
            })
        }
        
        private func getTopPadding() -> CGFloat {
            guard !constant.screen.activeSafeArea else { return 0 }
            return constant.axisMode == .top ? constant.tab.normalSize.height + safeAreaTop : 0
        }
    }

    struct TabButton: View {
        
        @Binding var constant: ATConstant
        @Binding var selection: Int
        
        let tag: Int
        let isSelection: Bool
        let systemName: String
        
        @State private var y: CGFloat = 0

        var content: some View {
            ZStack(alignment: .leading) {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 24))
                    .padding(10)
                    .frame(width: systemName == "plus.circle.fill" ? 65 : 50, height: systemName == "plus.circle.fill" ? 65 : 50)
            }
            .foregroundColor(isSelection ? (systemName == "plus.circle.fill" ? Color.accentColor : Color.accentColor) :(systemName == "plus.circle.fill" ? Color.accentColor : Color.black))
            .background(systemName == "plus.circle.fill" ? Color.white : Color.clear)
            .clipShape(Capsule())
            .offset(y: positionY)
        }
        
        var body: some View {
            if constant.axisMode == .top {
                content
            }else {
                content
            }
        }
        
        private var positionY: CGFloat {
            if systemName == "plus.circle.fill" {
                return constant.axisMode == .bottom ? -20 : 20
            }
            return 0
        }
    }
}

fileprivate
struct LinePreview: View {

    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
    @State private var radius: CGFloat = 76
    @State private var concaveDepth: CGFloat = 0.85
    @State private var color: Color = .white
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                CustomLineStyle(state, color: color)
            } content: {
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 0, systemName: "01.square.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 1, systemName: "02.square.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 2, systemName: "03.square.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 3, systemName: "04.square.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 4, systemName: "05.square.fill", safeAreaTop: proxy.safeAreaInsets.top)
            }
        }
        .animation(.easeInOut, value: constant)
        .animation(.easeInOut, value: radius)
        .animation(.easeInOut, value: concaveDepth)
        .navigationTitle("Screen \(selection + 1)")
    }
    
    struct ControllView: View {

        @Binding var selection: Int
        @Binding var constant: ATConstant
        @Binding var radius: CGFloat
        @Binding var concaveDepth: CGFloat
        @Binding var color: Color
        
        let tag: Int
        let systemName: String
        let safeAreaTop: CGFloat
        
        private var backgroundColor: Color {
            let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
            guard selection <= colors.count - 1 else { return Color(hex: 0x295A76)}
            return colors[selection].opacity(0.2)
        }
        
        private var content: some View {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("● AxisMode").opacity(0.5)
                    Picker(selection: $constant.axisMode) {
                        Text("Top")
                            .tag(ATAxisMode.top)
                        Text("Bottom")
                            .tag(ATAxisMode.bottom)
                    } label: {
                        Text("AxisMode")
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Screen Transition").opacity(0.5)
                    Picker(selection: $constant.screen.transitionMode) {
                        Text("Slide")
                            .tag(ATTransitionMode.slide(50))
                        Text("Opacity")
                            .tag(ATTransitionMode.opacity)
                        Text("Scale")
                            .tag(ATTransitionMode.scale(0.90))
                        Text("None")
                            .tag(ATTransitionMode.none)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading)
                    Toggle(isOn: $constant.screen.activeSafeArea) {
                        Text("SafeArea Toggle")
                    }
                    .padding(.horizontal)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Normal Size").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.width, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.width, specifier: "%.2f")")
                    }
                    .padding(.leading)
                    HStack {
                        Text("H").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.normalSize.height, in: 50...100)
                        Spacer()
                        Text("\(constant.tab.normalSize.height, specifier: "%.2f")")
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Select Width").opacity(0.5)
                    HStack {
                        Text("W").frame(width: 24, alignment: .leading)
                        Spacer()
                        Slider(value: $constant.tab.selectWidth, in: -1...200)
                        Spacer()
                        Text("\(constant.tab.selectWidth, specifier: "%.2f")")
                        
                    }
                    .padding(.leading)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("● Tab Spacing").opacity(0.5)
                    Picker(selection: $constant.tab.spacingMode) {
                        Text("Center")
                            .tag(ATSpacingMode.center)
                        Text("Average")
                            .tag(ATSpacingMode.average)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading)
                    HStack {
                        Text("Spacing")
                        Spacer()
                        Slider(value: $constant.tab.spacing, in: 0...30)
                        Spacer()
                        Text("\(constant.tab.spacing, specifier: "%.2f")")
                    }
                    .disabled(constant.tab.spacingMode == .average)
                    .opacity(constant.tab.spacingMode == .average ? 0.5 : 1.0)
                    .padding(.leading)
                    
                    HStack {
                        Text("Color")
                        Spacer()
                        ColorPicker("", selection: $color)
                    }
                    .padding(.leading)
                    .labelsHidden()
                }
            }
        }
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                if constant.axisMode == .bottom {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }else {
                    ScrollView {
                        content
                            .padding()
                            .padding(.top, getTopPadding())
                    }
                }
            }
            .tabItem(tag: tag, normal: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName)
            }, select: {
                TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName)
            })
        }
        
        private func getTopPadding() -> CGFloat {
            guard !constant.screen.activeSafeArea else { return 0 }
            return constant.axisMode == .top ? constant.tab.normalSize.height + safeAreaTop : 0
        }
    }

    struct TabButton: View {
        
        @Binding var constant: ATConstant
        @Binding var selection: Int
        
        let tag: Int
        let isSelection: Bool
        let systemName: String
        
        var content: some View {
            ZStack(alignment: .leading) {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 24))
                    .padding(10)

            }
            .foregroundColor(isSelection ? Color.accentColor : Color.black)
        }
        
        var body: some View {
            if constant.axisMode == .top {
                content
            }else {
                content
            }
        }
    }
}

struct P233_AxisTabView_Previews: PreviewProvider {
    static var previews: some View {
        P233_AxisTabView()
    }
}
