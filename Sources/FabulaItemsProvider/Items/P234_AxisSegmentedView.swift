//
//  P234_AxisSegmentedView.swift
//  
//
//  Created by jasu on 2022/03/27.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSegmentedView

public struct P234_AxisSegmentedView: View {
    
    @State private var tabViewSelection: Int = 0
    
    public init() {}
    
    private var content: some View {
        TabView(selection: $tabViewSelection) {
            SegmentedListView(axisMode: .horizontal)
                .tag(0)
                .tabItem {
                    Image(systemName: "rectangle.arrowtriangle.2.inward")
                    Text("Horizontal")
                }
            
            SegmentedListView(axisMode: .vertical)
                .tag(1)
                .tabItem {
                    Image(systemName: "rectangle.portrait.arrowtriangle.2.inward")
                    Text("Vertical")
                }
            
            WithoutStyleView()
                .tag(2)
                .tabItem {
                    Image(systemName: "cpu")
                    Text("Without style")
                }
            
            CustomStyleView()
                .tag(3)
                .tabItem {
                    Image(systemName: "skew")
                    Text("Custom Style")
                }
                .padding()
        }
        .navigationTitle(Text("AxisSegmentedView"))
    }
    
    public var body: some View {
        ZStack {
#if os(iOS)
            content
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(.stack)
#else
            content
                .padding()
#endif
        }
        .preferredColorScheme(.dark)
    }
}

fileprivate
struct SelectionItemView: View {
    
    @EnvironmentObject private var stateValue: ASStateValue
    @State private var scale: CGFloat = 1
    
    let iconName: String
    
    init(_ iconName: String) {
        self.iconName = iconName
    }
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(Color.white)
            .scaleEffect(scale)
            .onAppear {
                scale = 1
                if !stateValue.isInitialRun {
                    withAnimation(.easeInOut(duration: 0.26)) {
                        scale = 1.2
                    }
                    withAnimation(.easeInOut(duration: 0.26).delay(0.26)) {
                        scale = 1
                    }
                }
            }
    }
}

fileprivate
enum StyleType: String {
    case ASNormalStyle
    case ASViscosityStyle
    
    case ASBasicStyle
    case ASCapsuleStyle
    case ASJellyStyle
    case ASLineStyle
    case ASNeumorphismStyle
    case ASScaleStyle
}

fileprivate
struct SegmentedListView: View {
    
    let axisMode: ASAxisMode
    
    @StateObject private var normalValue:       NormalValue = .init()
    @StateObject private var viscosityValue:    ViscosityValue = .init()
    
    @StateObject private var basicValue:        BasicValue = .init()
    @StateObject private var capsuleValue:      CapsuleValue = .init()
    @StateObject private var jellyValue:        JellyValue = .init()
    @StateObject private var lineValue:         LineValue = .init()
    @StateObject private var neumorphismValue:  NeumorphismValue = .init()
    @StateObject private var scaleValue:        ScaleValue = .init()
    
    var content: some View {
        Group {
            SegmentedViewWithControl(title: "ABNormalStyle", styleType: .ASNormalStyle, axisMode: axisMode, constant: $normalValue.constant, tabs: {
                Group {
                    Text("Clear")
                        .font(.callout)
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(0, selectArea: normalValue.selectArea0) {
                            HStack {
                                Image(systemName: "checkmark.circle")
                                Text("Clear")
                            }
                            .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                            .font(.callout)
                            .foregroundColor(Color.white)
                        }
                    Text("Confusing")
                        .font(.callout)
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(1, selectArea: normalValue.selectArea1) {
                            HStack {
                                Image(systemName: "checkmark.circle")
                                Text("Confusing")
                            }
                            .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                            .font(.callout)
                            .foregroundColor(Color.white)
                        }
                }
            }, style: {
                ASNormalStyle { _ in
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(hex: 0x191919))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke()
                                .fill(Color(hex: 0x282828))
                        )
                        .padding(3.5)
                }
                .background(Color(hex: 0x0B0C10))
                .clipShape(RoundedRectangle(cornerRadius: 5))
            })
            SegmentedViewWithControl(title: "ASViscosityStyle", styleType: .ASViscosityStyle, axisMode: axisMode, constant: $viscosityValue.constant, tabs: {
                Group {
                    Text("Store")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(0, selectArea: viscosityValue.selectArea0) {
                            Text("Store")
                                .font(.callout)
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                    Text("Library")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(1, selectArea: viscosityValue.selectArea1) {
                            Text("Library")
                                .font(.callout)
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                    Text("Downloads")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(2, selectArea: viscosityValue.selectArea2) {
                            Text("Downloads")
                                .font(.callout)
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                }
            }, style: {
                ASViscosityStyle { _ in
                    Capsule()
                        .fill(LinearGradient(colors: [Color(hex: 0x222222), Color(hex: 0x111111)],
                                             startPoint: axisMode == .horizontal ? UnitPoint.top : UnitPoint.leading,
                                             endPoint: axisMode == .horizontal ? UnitPoint.bottom : UnitPoint.trailing))
                        .overlay(
                            Capsule()
                                .stroke()
                                .fill(Color.black)
                        )
                        .padding(2)
                }
                .background(Color.black.opacity(0.2))
                .clipShape(Capsule())
                .innerShadow(Capsule(), radius: 1, opacity: 0.5, isDark: true)
            })
            
            SegmentedViewWithControl(title: "ASBasicStyle", styleType: .ASBasicStyle, axisMode: axisMode, constant: $basicValue.constant, tabs: {
                Group {
                    Text("Male")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(0, selectArea: basicValue.selectArea0) {
                            Text("Male")
                                .font(.callout)
                                .fixedSize()
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                    Text("Female")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(1, selectArea: basicValue.selectArea1) {
                            Text("Female")
                                .font(.callout)
                                .fixedSize()
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                    Text("Other")
                        .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                        .font(.callout)
                        .foregroundColor(Color.white.opacity(0.5))
                        .itemTag(2, selectArea: basicValue.selectArea2) {
                            Text("Other")
                                .font(.callout)
                                .fixedSize()
                                .rotationEffect(Angle(degrees: axisMode == .horizontal ? 0 : -90))
                                .foregroundColor(Color.white)
                        }
                }
            }, style: {
                ASBasicStyle(backgroundColor: basicValue.backgroundColor,
                             foregroundColor: basicValue.foregroundColor,
                             cornerRadius: basicValue.cornerRadius,
                             padding: basicValue.padding,
                             isApplySelectionCornerRadius: basicValue.isApplySelectionCornerRadius,
                             movementMode: basicValue.movementMode)
            })
            
            SegmentedViewWithControl(title: "ASJellyStyle", styleType: .ASJellyStyle, axisMode: axisMode, constant: $jellyValue.constant, tabs: {
                Group {
                    Image(systemName: "align.horizontal.left")
                        .itemTag(0, selectArea: jellyValue.selectArea0) {
                            SelectionItemView("align.horizontal.left.fill")
                        }
                    Image(systemName: "align.horizontal.right")
                        .itemTag(1, selectArea: jellyValue.selectArea1) {
                            SelectionItemView("align.horizontal.right.fill")
                        }
                    Image(systemName: "align.vertical.top")
                        .itemTag(2, selectArea: jellyValue.selectArea2) {
                            SelectionItemView("align.vertical.top.fill")
                        }
                    Image(systemName: "align.vertical.bottom")
                        .itemTag(3, selectArea: jellyValue.selectArea3) {
                            SelectionItemView("align.vertical.bottom.fill")
                        }
                }
            }, style: {
                ASJellyStyle(backgroundColor: jellyValue.backgroundColor,
                             foregroundColor: jellyValue.foregroundColor,
                             jellyRadius: jellyValue.jellyRadius,
                             jellyDepth: jellyValue.jellyDepth,
                             jellyEdge: jellyValue.jellyEdge)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 11)
//                                        .stroke(.purple, lineWidth: 1)
//                                        .padding(1)
//                                )
//                                .clipShape(RoundedRectangle(cornerRadius: 11))
            })
            
            SegmentedViewWithControl(title: "ASLineStyle", styleType: .ASLineStyle, axisMode: axisMode, constant: $lineValue.constant, tabs: {
                Group {
                    Image(systemName: "align.horizontal.left")
                        .itemTag(0, selectArea: lineValue.selectArea0) {
                            SelectionItemView("align.horizontal.left.fill")
                        }
                    Image(systemName: "align.horizontal.right")
                        .itemTag(1, selectArea: lineValue.selectArea1) {
                            SelectionItemView("align.horizontal.right.fill")
                        }
                    Image(systemName: "align.vertical.top")
                        .itemTag(2, selectArea: lineValue.selectArea2) {
                            SelectionItemView("align.vertical.top.fill")
                        }
                    Image(systemName: "align.vertical.bottom")
                        .itemTag(3, selectArea: lineValue.selectArea3) {
                            SelectionItemView("align.vertical.bottom.fill")
                        }
                }
            }, style: {
                ASLineStyle(lineColor: lineValue.lineColor,
                            lineSmallWidth: lineValue.lineSmallWidth,
                            lineLargeScale: lineValue.lineLargeScale,
                            lineEdge: lineValue.lineEdge,
                            movementMode: lineValue.movementMode)
                .overlay(
                    Rectangle()
                        .stroke()
                        .fill(Color(hex: 0x303030))
                )
            })
            
            SegmentedViewWithControl(title: "ASCapsuleStyle", styleType: .ASCapsuleStyle, axisMode: axisMode, constant: $capsuleValue.constant, tabs: {
                Group {
                    Image(systemName: "align.horizontal.left")
                        .itemTag(0, selectArea: capsuleValue.selectArea0) {
                            SelectionItemView("align.horizontal.left.fill")
                        }
                    Image(systemName: "align.horizontal.right")
                        .itemTag(1, selectArea: capsuleValue.selectArea1) {
                            SelectionItemView("align.horizontal.right.fill")
                        }
                    Image(systemName: "align.vertical.top")
                        .itemTag(2, selectArea: capsuleValue.selectArea2) {
                            SelectionItemView("align.vertical.top.fill")
                        }
                    Image(systemName: "align.vertical.bottom")
                        .itemTag(3, selectArea: capsuleValue.selectArea3) {
                            SelectionItemView("align.vertical.bottom.fill")
                        }
                }
            }, style: {
                ASCapsuleStyle(backgroundColor: capsuleValue.backgroundColor,
                               foregroundColor: capsuleValue.foregroundColor,
                               movementMode: capsuleValue.movementMode)
            })

            SegmentedViewWithControl(title: "ASNeumorphismStyle", styleType: .ASNeumorphismStyle, axisMode: axisMode, constant: $neumorphismValue.constant, area: 70, tabs: {
                Group {
                    Image(systemName: "align.horizontal.left")
                        .itemTag(0, selectArea: neumorphismValue.selectArea0) {
                            SelectionItemView("align.horizontal.left.fill")
                        }
                    Image(systemName: "align.horizontal.right")
                        .itemTag(1, selectArea: neumorphismValue.selectArea1) {
                            SelectionItemView("align.horizontal.right.fill")
                        }
                    Image(systemName: "align.vertical.top")
                        .itemTag(2, selectArea: neumorphismValue.selectArea2) {
                            SelectionItemView("align.vertical.top.fill")
                        }
                    Image(systemName: "align.vertical.bottom")
                        .itemTag(3, selectArea: neumorphismValue.selectArea3) {
                            SelectionItemView("align.vertical.bottom.fill")
                        }
                }
            }, style: {
                ASNeumorphismStyle(backgroundColor: neumorphismValue.backgroundColor,
                                   foregroundColor: neumorphismValue.foregroundColor,
                                   cornerRadius: neumorphismValue.cornerRadius,
                                   padding: neumorphismValue.padding,
                                   shadowRadius: neumorphismValue.shadowRadius,
                                   shadowOpacity: neumorphismValue.shadowOpacity,
                                   isInner: neumorphismValue.isInner,
                                   movementMode: neumorphismValue.movementMode)
            })
            
            SegmentedViewWithControl(title: "ASScaleStyle", styleType: .ASScaleStyle, axisMode: axisMode, constant: $scaleValue.constant, tabs: {
                Group {
                    Image(systemName: "align.horizontal.left")
                        .itemTag(0, selectArea: scaleValue.selectArea0) {
                            SelectionItemView("align.horizontal.left.fill")
                        }
                    Image(systemName: "align.horizontal.right")
                        .itemTag(1, selectArea: scaleValue.selectArea1) {
                            SelectionItemView("align.horizontal.right.fill")
                        }
                    Image(systemName: "align.vertical.top")
                        .itemTag(2, selectArea: scaleValue.selectArea2) {
                            SelectionItemView("align.vertical.top.fill")
                        }
                    Image(systemName: "align.vertical.bottom")
                        .itemTag(3, selectArea: scaleValue.selectArea3) {
                            SelectionItemView("align.vertical.bottom.fill")
                        }
                }
            }, style: {
                ASScaleStyle(backgroundColor: scaleValue.backgroundColor,
                             foregroundColor: scaleValue.foregroundColor,
                             cornerRadius: scaleValue.cornerRadius,
                             minimumScale: scaleValue.minimumScale)
            })
        }
    }
    var body: some View {
        ZStack {
            if axisMode == .horizontal {
                ScrollView {
                    VStack(spacing: 20) {
                        content
                    }
                    .padding(.horizontal, 5)
                }
            }else {
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        content
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .environmentObject(normalValue)
        .environmentObject(viscosityValue)
        .environmentObject(basicValue)
        .environmentObject(capsuleValue)
        .environmentObject(jellyValue)
        .environmentObject(lineValue)
        .environmentObject(neumorphismValue)
        .environmentObject(scaleValue)
    }
}

fileprivate
struct SegmentedViewWithControl<Tabs: View, Style: View> : View {
    
    @State private var isShowControlView: Bool = false
    @State private var selection: Int = 0
    @State private var maxSelectArea: CGFloat = 0

    @EnvironmentObject private var normalValue:         NormalValue
    @EnvironmentObject private var viscosityValue:      ViscosityValue
    
    @EnvironmentObject private var basicValue:          BasicValue
    @EnvironmentObject private var capsuleValue:        CapsuleValue
    @EnvironmentObject private var jellyValue:          JellyValue
    @EnvironmentObject private var lineValue:           LineValue
    @EnvironmentObject private var neumorphismValue:    NeumorphismValue
    @EnvironmentObject private var scaleValue:          ScaleValue
    
    let title: String
    let styleType: StyleType
    let axisMode: ASAxisMode
    @Binding var constant: ASConstant
    let area: CGFloat
    var tabs: () -> Tabs
    var style: () -> Style
    
    init(title: String,
         styleType: StyleType,
         axisMode: ASAxisMode = .horizontal,
         constant: Binding<ASConstant>,
         area: CGFloat = 44,
         @ViewBuilder tabs: @escaping () -> Tabs,
         @ViewBuilder style: @escaping () -> Style) {
        self.title = title
        self.styleType = styleType
        self.axisMode = axisMode
        _constant = constant
        self.area = area
        self.tabs = tabs
        self.style = style
    }
    
    private var segmentedView: some View {
        AxisSegmentedView(selection: $selection, constant: constant, {
            tabs()
        }, style: {
            style()
        })
        .font(.system(size: 20))
    }
    
    private var controlView: some View {
        ZStack {
            Color(hex: 0x030303)
                .cornerRadius(8)
            ScrollView {
                VStack {
                    getStyleControlView()
                    VStack(alignment: .leading, spacing: 8) {
                        Text("● Divide Line").opacity(0.5).font(.caption)
                        HStack {
                            Text("Color")
                            Spacer()
                            ColorPicker(selection: $constant.divideLine.color) {}
                        }
                        HStack {
                            Text("Width")
                            Spacer()
                            Slider(value: $constant.divideLine.width, in: 0...5)
                            Spacer()
                            Text("\(constant.divideLine.width, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Scale")
                            Spacer()
                            Slider(value: $constant.divideLine.scale, in: 0...1)
                            Spacer()
                            Text("\(constant.divideLine.scale, specifier: "%.2f")")
                        }
                        HStack {
                            Text("isShowSelectionLine")
                            Spacer()
                            Toggle(isOn: $constant.divideLine.isShowSelectionLine) {}
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("● Active").opacity(0.5).font(.caption)
                        HStack {
                            Text("ActivatedGeometryEffect")
                            Spacer()
                            Toggle(isOn: $constant.isActivatedGeometryEffect) {}
                        }
                        HStack {
                            Text("ActivatedVibration")
                            Spacer()
                            Toggle(isOn: $constant.isActivatedVibration) {}
                        }
                    }
                    .padding()
                }
            }
            .font(.footnote)
            .labelsHidden()
        }
    }
    
    var body: some View {
        ZStack {
            ZStack {
                if constant.axisMode == .horizontal {
                    VStack {
                        HStack {
                            Text(title)
                                .font(.caption)
                                .foregroundColor(Color.white.opacity(0.6))
                            Spacer()
                            Image(systemName: "chevron.down")
                                .frame(width: 36, height: 36)
                                .rotationEffect(Angle(degrees: isShowControlView ? -180 : 0))
                                .contentShape(Rectangle())
                        }
                        .frame(height: 36)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isShowControlView.toggle()
                            }
                        }
                        
                        VStack(spacing: 0) {
                            segmentedView
                                .frame(height: area)
                            Spacer().frame(height: 10)
                            controlView
                                .opacity(isShowControlView ? 1 : 0)
                                .frame(height: isShowControlView ? 400 : 0)
                        }
                    }
                }else {
                    VStack {
                        HStack {
                            Text(title)
                                .font(.caption)
                                .foregroundColor(Color.white.opacity(0.6))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 36, height: 36)
                                .rotationEffect(Angle(degrees: isShowControlView ? -180 : 0))
                                .contentShape(Rectangle())
                        }
                        .frame(height: 36)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isShowControlView.toggle()
                            }
                        }
                        HStack(spacing: 0) {
                            segmentedView
                                .frame(width: area)
                            Spacer().frame(width: 10)
                            controlView
                                .frame(width: 260)
                                .mask(
                                    Rectangle()
                                        .frame(width: isShowControlView ? 260 : 0)
                                )
                                .opacity(isShowControlView ? 1 : 0)
                                .frame(width: isShowControlView ? 260 : 0)
                        }
                    }
                }
            }
            .padding(10)
        }
        .background(
            GeometryReader { proxy in
                Color(hex: 0x15151A)
                    .cornerRadius(8)
                    .onAppear {
                        self.maxSelectArea = constant.axisMode == .horizontal ? proxy.size.width * 0.5 : proxy.size.height * 0.5
                    }
            }
        )
        .onAppear {
            constant.axisMode = axisMode
        }
    }
    
    private func getStyleControlView() -> some View {
        Group {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("● " + title).opacity(0.5).font(.caption)
                    Spacer()
                }
                switch styleType {
                case .ASNormalStyle:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("● SelectArea").opacity(0.5).font(.caption)
                        HStack {
                            Text("0")
                                .font(.system(size: 16))
                            Spacer()
                            Slider(value: $normalValue.selectArea0, in: 0...maxSelectArea)
                            Spacer()
                            Text("\(normalValue.selectArea0, specifier: "%.2f")")
                        }
                        HStack {
                            Text("1")
                                .font(.system(size: 16))
                            Spacer()
                            Slider(value: $normalValue.selectArea1, in: 0...maxSelectArea)
                            Spacer()
                            Text("\(normalValue.selectArea1, specifier: "%.2f")")
                        }
                    }
                    .padding(.top, 20)
                case .ASViscosityStyle:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("● SelectArea").opacity(0.5).font(.caption)
                        HStack {
                            Text("0")
                                .font(.system(size: 16))
                            Spacer()
                            Slider(value: $viscosityValue.selectArea0, in: 0...maxSelectArea)
                            Spacer()
                            Text("\(viscosityValue.selectArea0, specifier: "%.2f")")
                        }
                        HStack {
                            Text("1")
                                .font(.system(size: 16))
                            Spacer()
                            Slider(value: $viscosityValue.selectArea1, in: 0...maxSelectArea)
                            Spacer()
                            Text("\(viscosityValue.selectArea1, specifier: "%.2f")")
                        }
                        HStack {
                            Text("2")
                                .font(.system(size: 16))
                            Spacer()
                            Slider(value: $viscosityValue.selectArea2, in: 0...maxSelectArea)
                            Spacer()
                            Text("\(viscosityValue.selectArea2, specifier: "%.2f")")
                        }
                    }
                    .padding(.top, 20)
                case .ASBasicStyle:
                    Group {
                        HStack {
                            Text("Background Color")
                            Spacer()
                            ColorPicker(selection: $basicValue.backgroundColor) {}
                        }
                        HStack {
                            Text("Foreground Color")
                            Spacer()
                            ColorPicker(selection: $basicValue.foregroundColor) {}
                        }
                        HStack {
                            Text("Corner Raddius")
                            Spacer()
                            Slider(value: $basicValue.cornerRadius, in: 0...22)
                            Spacer()
                            Text("\(basicValue.cornerRadius, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Padding")
                            Spacer()
                            Slider(value: $basicValue.padding, in: 0...6)
                            Spacer()
                            Text("\(basicValue.padding, specifier: "%.2f")")
                        }
                        HStack {
                            Text("isApplySelectionCornerRadius")
                            Spacer()
                            Toggle(isOn: $basicValue.isApplySelectionCornerRadius) {}
                        }
                        HStack {
                            Text("Movement Mode")
                            Spacer()
                            Picker(selection: $basicValue.movementMode) {
                                Text("Normal").tag(ASMovementMode.normal)
                                Text("Viscosity").tag(ASMovementMode.viscosity)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $basicValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(basicValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $basicValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(basicValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $basicValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(basicValue.selectArea2, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
                case .ASCapsuleStyle:
                    Group {
                        HStack {
                            Text("Background Color")
                            Spacer()
                            ColorPicker(selection: $capsuleValue.backgroundColor) {}
                        }
                        HStack {
                            Text("Foreground Color")
                            Spacer()
                            ColorPicker(selection: $capsuleValue.foregroundColor) {}
                        }
                        HStack {
                            Text("Movement Mode")
                            Spacer()
                            Picker(selection: $capsuleValue.movementMode) {
                                Text("Normal").tag(ASMovementMode.normal)
                                Text("Viscosity").tag(ASMovementMode.viscosity)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $capsuleValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(capsuleValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $capsuleValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(capsuleValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $capsuleValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(capsuleValue.selectArea2, specifier: "%.2f")")
                            }
                            HStack {
                                Text("3")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $capsuleValue.selectArea3, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(capsuleValue.selectArea3, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
                case .ASJellyStyle:
                    Group {
                        HStack {
                            Text("Background Color")
                            Spacer()
                            ColorPicker(selection: $jellyValue.backgroundColor) {}
                        }
                        HStack {
                            Text("Foreground Color")
                            Spacer()
                            ColorPicker(selection: $jellyValue.foregroundColor) {}
                        }
                        HStack {
                            Text("Jelly Raddius")
                            Spacer()
                            Slider(value: $jellyValue.jellyRadius, in: 0...100)
                            Spacer()
                            Text("\(jellyValue.jellyRadius, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Jelly Depth")
                            Spacer()
                            Slider(value: $jellyValue.jellyDepth, in: 0...1.0)
                            Spacer()
                            Text("\(jellyValue.jellyDepth, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Jelly Edge")
                            Spacer()
                            Picker(selection: $jellyValue.jellyEdge) {
                                Text("Bottom/Trailing").tag(ASEdgeMode.bottomTrailing)
                                Text("Top/Leading").tag(ASEdgeMode.topLeading)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $jellyValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(jellyValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $jellyValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(jellyValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $jellyValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(jellyValue.selectArea2, specifier: "%.2f")")
                            }
                            HStack {
                                Text("3")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $jellyValue.selectArea3, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(jellyValue.selectArea3, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
                case .ASLineStyle:
                    Group {
                        HStack {
                            Text("Line Color")
                            Spacer()
                            ColorPicker(selection: $lineValue.lineColor) {}
                        }
                        HStack {
                            Text("Line Small Width")
                            Spacer()
                            Slider(value: $lineValue.lineSmallWidth, in: 0...6)
                            Spacer()
                            Text("\(lineValue.lineSmallWidth, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Line Large Scale")
                            Spacer()
                            Slider(value: $lineValue.lineLargeScale, in: 0...1)
                            Spacer()
                            Text("\(lineValue.lineLargeScale, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Line Edge")
                            Spacer()
                            Picker(selection: $lineValue.lineEdge) {
                                Text("Bottom/Trailing").tag(ASEdgeMode.bottomTrailing)
                                Text("Top/Leading").tag(ASEdgeMode.topLeading)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                        HStack {
                            Text("Movement Mode")
                            Spacer()
                            Picker(selection: $lineValue.movementMode) {
                                Text("Normal").tag(ASMovementMode.normal)
                                Text("Viscosity").tag(ASMovementMode.viscosity)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $lineValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(lineValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $lineValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(lineValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $lineValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(lineValue.selectArea2, specifier: "%.2f")")
                            }
                            HStack {
                                Text("3")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $lineValue.selectArea3, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(lineValue.selectArea3, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
                case .ASNeumorphismStyle:
                    Group {
                        HStack {
                            Text("Background Color")
                            Spacer()
                            ColorPicker(selection: $neumorphismValue.backgroundColor) {}
                        }
                        HStack {
                            Text("Foreground Color")
                            Spacer()
                            ColorPicker(selection: $neumorphismValue.foregroundColor) {}
                        }
                        HStack {
                            Text("Corner Raddius")
                            Spacer()
                            Slider(value: $neumorphismValue.cornerRadius, in: 0...35)
                            Spacer()
                            Text("\(neumorphismValue.cornerRadius, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Shadow Raddius")
                            Spacer()
                            Slider(value: $neumorphismValue.shadowRadius, in: 0...7)
                            Spacer()
                            Text("\(neumorphismValue.shadowRadius, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Padding")
                            Spacer()
                            Slider(value: $neumorphismValue.padding, in: 0...12)
                            Spacer()
                            Text("\(neumorphismValue.padding, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Shadow Opacity")
                            Spacer()
                            Slider(value: $neumorphismValue.shadowOpacity, in: 0...1)
                            Spacer()
                            Text("\(neumorphismValue.shadowOpacity, specifier: "%.2f")")
                        }
                        HStack {
                            Text("isInner")
                            Spacer()
                            Toggle(isOn: $neumorphismValue.isInner) {}
                        }
                        HStack {
                            Text("Movement Mode")
                            Spacer()
                            Picker(selection: $neumorphismValue.movementMode) {
                                Text("Normal").tag(ASMovementMode.normal)
                                Text("Viscosity").tag(ASMovementMode.viscosity)
                            } label: {}
                                .pickerStyle(.segmented)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $neumorphismValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(neumorphismValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $neumorphismValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(neumorphismValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $neumorphismValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(neumorphismValue.selectArea2, specifier: "%.2f")")
                            }
                            HStack {
                                Text("3")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $neumorphismValue.selectArea3, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(neumorphismValue.selectArea3, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
                case .ASScaleStyle:
                    Group {
                        HStack {
                            Text("Background Color")
                            Spacer()
                            ColorPicker(selection: $scaleValue.backgroundColor) {}
                        }
                        HStack {
                            Text("Foreground Color")
                            Spacer()
                            ColorPicker(selection: $scaleValue.foregroundColor) {}
                        }
                        HStack {
                            Text("Corner Raddius")
                            Spacer()
                            Slider(value: $scaleValue.cornerRadius, in: 0...22)
                            Spacer()
                            Text("\(scaleValue.cornerRadius, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Minimum Scale")
                            Spacer()
                            Slider(value: $scaleValue.minimumScale, in: 0...1)
                            Spacer()
                            Text("\(scaleValue.minimumScale, specifier: "%.2f")")
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("● SelectArea").opacity(0.5).font(.caption)
                            HStack {
                                Text("0")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $scaleValue.selectArea0, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(scaleValue.selectArea0, specifier: "%.2f")")
                            }
                            HStack {
                                Text("1")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $scaleValue.selectArea1, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(scaleValue.selectArea1, specifier: "%.2f")")
                            }
                            HStack {
                                Text("2")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $scaleValue.selectArea2, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(scaleValue.selectArea2, specifier: "%.2f")")
                            }
                            HStack {
                                Text("3")
                                    .font(.system(size: 16))
                                Spacer()
                                Slider(value: $scaleValue.selectArea3, in: 0...maxSelectArea)
                                Spacer()
                                Text("\(scaleValue.selectArea3, specifier: "%.2f")")
                            }
                        }
                        .padding(.top, 20)
                    }
                }
            }
            .padding()
        }
    }
}

fileprivate
struct WithoutStyleView: View {
    
    @State private var selection1: Int = 0
    @State private var constant1 = ASConstant(axisMode: .vertical)
    
    @State private var selection2: Int = 0
    @State private var constant2 = ASConstant(axisMode: .horizontal)

    var body: some View {
        VStack {
            AxisSegmentedView(selection: $selection1, constant: constant1) {
                TabViews()
            }
            .clipped()
            AxisSegmentedView(selection: $selection2, constant: constant2) {
                TabViews()
            }
            .clipped()
        }
    }
}

fileprivate
struct TabViews: View {
    
    @State private var maxArea1: CGFloat = 200
    @EnvironmentObject private var stateValue: ASStateValue
    
    let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
    
    var listView: some View {
        List(0...100, id: \.self) { index in
            Button {
                print("click")
            } label: {
                Text("Index \(index)")
            }
        }.listStyle(.plain)
    }
    
    var body: some View {
        Group {
            Rectangle()
                .fill(colors[0])
                .overlay(
                    Text("0")
                )
                .itemTag(0, selectArea: maxArea1) {
                    Rectangle()
                        .fill(.red)
                        .overlay(
                            Text("0")
                        )
                }
            Rectangle()
                .fill(colors[1])
                .overlay(
                    Text("1")
                )
                .itemTag(1, selectArea: maxArea1) {
                    listView
                }
            Rectangle()
                .fill(colors[2])
                .overlay(
                    Text("2")
                )
                .itemTag(2, selectArea: maxArea1) {
                    listView
                }
            Rectangle()
                .fill(colors[3])
                .overlay(
                    Text("3")
                )
                .itemTag(3, selectArea: maxArea1) {
                    listView
                }
        }
    }
}

fileprivate
struct CustomStyleView: View {
    
    @State private var selection: Int = 0
    
    var body: some View {
        HStack {
            AxisSegmentedView(selection: $selection, constant: .init(axisMode: .vertical)) {
                Image(systemName: "align.horizontal.left")
                    .itemTag(0, selectArea: 0) {
                        SelectionItemView("align.horizontal.left.fill")
                    }
                Image(systemName: "align.horizontal.right")
                    .itemTag(1, selectArea: 260) {
                        SelectionItemView("align.horizontal.right.fill")
                    }
                Image(systemName: "align.vertical.top")
                    .itemTag(2, selectArea: 0) {
                        SelectionItemView("align.vertical.top.fill")
                    }
                Image(systemName: "align.vertical.bottom")
                    .itemTag(3, selectArea: 260) {
                        SelectionItemView("align.vertical.bottom.fill")
                    }
            } style: {
                CustomStyle(color: .blue)
            }
            .frame(width: 44)
            
            AxisSegmentedView(selection: $selection, constant: .init()) {
                Image(systemName: "align.horizontal.left")
                    .itemTag(0, selectArea: 0) {
                        SelectionItemView("align.horizontal.left.fill")
                    }
                Image(systemName: "align.horizontal.right")
                    .itemTag(1, selectArea: 160) {
                        SelectionItemView("align.horizontal.right.fill")
                    }
                Image(systemName: "align.vertical.top")
                    .itemTag(2, selectArea: 0) {
                        SelectionItemView("align.vertical.top.fill")
                    }
                Image(systemName: "align.vertical.bottom")
                    .itemTag(3, selectArea: 160) {
                        SelectionItemView("align.vertical.bottom.fill")
                    }
            } style: {
                CustomStyle(color: .red)
            }
            .frame(height: 44)
        }
    }
}

fileprivate
struct CustomStyle: View {
    
    @EnvironmentObject var stateValue: ASStateValue

    let color: Color
    
    init(color: Color = .purple) {
        self.color = color
    }
    
    private var selectionView: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.yellow)
    }
    
    var body: some View {
        let selectionFrame = stateValue.selectionFrame
        ZStack(alignment: .topLeading) {
            Color.clear
            RoundedRectangle(cornerRadius: 5)
                .stroke()
                .fill(color)
                .frame(width: selectionFrame.width, height: selectionFrame.height)
                .offset(x: selectionFrame.origin.x, y: selectionFrame.origin.y)
        }
        .animation(.easeInOut, value: stateValue.selectionIndex)
    }
}

fileprivate
class BasicValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color.white.opacity(0.2), scale: 0.3))
    
    @Published var backgroundColor: Color = .gray.opacity(0.3)
    @Published var foregroundColor: Color = .black.opacity(0.7)
    @Published var cornerRadius: CGFloat = 6
    @Published var padding: CGFloat = 3
    @Published var isApplySelectionCornerRadius: Bool = true
    @Published var movementMode: ASMovementMode = .viscosity
    
    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
}

fileprivate
class NormalValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color(hex: 0x444444), scale: 0))
    
    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0

}

fileprivate
class ViscosityValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color(hex: 0x444444), scale: 0))

    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
}

fileprivate
class CapsuleValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color(hex: 0x444444), scale: 0))
    
    @Published var backgroundColor: Color = .gray.opacity(0.4)
    @Published var foregroundColor: Color = Color.blue
    @Published var movementMode: ASMovementMode = .viscosity
    
    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
    @Published var selectArea3: CGFloat = 0
}

fileprivate
class JellyValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color(hex: 0x444444), scale: 0))
    
    @Published var backgroundColor: Color = .gray.opacity(0.1)
    @Published var foregroundColor: Color = .purple
    @Published var jellyRadius: CGFloat = 56
    @Published var jellyDepth: CGFloat = 0.9
    @Published var jellyEdge: ASEdgeMode = .bottomTrailing
    
    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
    @Published var selectArea3: CGFloat = 0
}

fileprivate
class LineValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color(hex: 0x202020), scale: 0))
    
    @Published var lineColor: Color = .blue
    @Published var lineSmallWidth: CGFloat = 2
    @Published var lineLargeScale: CGFloat = 1.0
    @Published var lineEdge: ASEdgeMode = .bottomTrailing
    @Published var movementMode: ASMovementMode = .viscosity
    
    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
    @Published var selectArea3: CGFloat = 0
}

fileprivate
class NeumorphismValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color(hex: 0x444444), scale: 0))
    
    @Published var backgroundColor: Color = .clear
    @Published var foregroundColor: Color = .clear
    @Published var cornerRadius: CGFloat = 11
    @Published var padding: CGFloat = 12
    @Published var shadowRadius: CGFloat = 5
    @Published var shadowOpacity: CGFloat = 0.7
    @Published var isInner: Bool = false
    @Published var movementMode: ASMovementMode = .viscosity

    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
    @Published var selectArea3: CGFloat = 0
    
    init(backgroundColor: Color = Color(hex: 0x31353A),
         foregroundColor: Color = Color(hex: 0x31353A),
         cornerRadius: CGFloat = 11,
         padding: CGFloat = 12,
         shadowRadius: CGFloat = 5,
         shadowOpacity: CGFloat = 0.7,
         isInner: Bool = false,
         movementMode: ASMovementMode = .viscosity) {
        
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.shadowRadius = shadowRadius
        self.isInner = isInner
        self.movementMode = movementMode
    }
}

fileprivate
class ScaleValue: ObservableObject {
    
    @Published var constant = ASConstant(divideLine: .init(color: Color(hex: 0x444444), scale: 0))
    
    @Published var backgroundColor: Color = .clear
    @Published var foregroundColor: Color = Color.blue
    @Published var cornerRadius: CGFloat = 11
    @Published var minimumScale: CGFloat = 0.1
    
    @Published var selectArea0: CGFloat = 0
    @Published var selectArea1: CGFloat = 0
    @Published var selectArea2: CGFloat = 0
    @Published var selectArea3: CGFloat = 0
}

struct P234_AxisSegmentedView_Previews: PreviewProvider {
    static var previews: some View {
        P234_AxisSegmentedView()
    }
}
