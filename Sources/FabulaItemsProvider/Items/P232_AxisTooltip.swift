//
//  P232_AxisTooltip.swift
//  
//
//  Created by jasu on 2022/03/01.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisTooltip

public struct P232_AxisTooltip: View {
    
    @State private var isPresented: Bool = true
    @State private var constant: ATConstant = .init(border: ATBorderConstant(color: .pink))
    let alignments: [Alignment] = [.center, .leading, .trailing, .top, .bottom, .topLeading, .topTrailing, .bottomLeading, .bottomTrailing]
    @State private var alignmentIndex: Int = 0
    
    public init() {}
    public var body: some View {
        VStack {
            ZStack {
                Text("AxisTooltip")
                    .bold()
                    .padding()
                    .background(Color.pink)
                    .cornerRadius(10)
                    .onTapGesture {
                        isPresented.toggle()
                    }
                    .axisToolTip(isPresented: $isPresented, alignment: alignments[alignmentIndex], constant: constant, foreground: {
                        Label("Contrary to popular belief, Lorem Ipsum is not simply random text.", systemImage: "heart")
                            .padding()
                            .frame(width: 200)
                    })
            }
            .background(Color.blue.opacity(0.2))
            Spacer()
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("● Border").foregroundColor(Color.accentColor).opacity(0.5)
                    HStack {
                        HStack {
                            Text("   color :").opacity(0.5)
                            ColorPicker("", selection: $constant.border.color).labelsHidden()
                        }
                        Divider().frame(maxHeight: 40)
                        HStack {
                            Text("   style :").opacity(0.5)
                            Button {
                                if constant.border.style == nil {
                                    constant.border.style = StrokeStyle(lineWidth: 2, dash: [5])
                                }else {
                                    constant.border.style = nil
                                }
                            } label: {
                                Text(constant.border.style == nil ? "Off" : "On")
                                    .padding(7)
                                    .background(constant.border.style == nil ? Color.gray.opacity(0.2) : Color.accentColor)
                                    .cornerRadius(8)
                            }
                            .buttonStyle((PlainButtonStyle()))
                        }
                    }
                    HStack {
                        Text("   radius :").opacity(0.5)
                        Slider(value: $constant.border.radius, in: 0...26)
                        Text("\(constant.border.radius, specifier: "%.2f")")
                    }
                    HStack {
                        Text("   lineWidth :").opacity(0.5)
                        Slider(value: $constant.border.lineWidth, in: 0...26)
                        Text("\(constant.border.lineWidth, specifier: "%.2f")")
                    }
                    .disabled(constant.border.style != nil)
                    .opacity(constant.border.style != nil ? 0.5 : 1)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("● Arrow").foregroundColor(Color.accentColor).opacity(0.5)
                    HStack {
                        VStack {
                            HStack {
                                Text("   width : ").opacity(0.5)
                                Spacer()
                                Text("\(constant.arrow.width, specifier: "%.2f")")
                            }
                            Slider(value: $constant.arrow.width, in: 0...26)
                        }
                        Divider().frame(maxHeight: 40)
                        VStack {
                            HStack {
                                Text("   height : ").opacity(0.5)
                                Spacer()
                                Text("\(constant.arrow.height, specifier: "%.2f")")
                            }
                            Slider(value: $constant.arrow.height, in: 0...26)
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("● distance").foregroundColor(Color.accentColor).opacity(0.5)
                    HStack {
                        Slider(value: $constant.distance, in: 0...26)
                        Text("\(constant.distance, specifier: "%.2f")")
                    }
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("● AxisMode").foregroundColor(Color.accentColor).opacity(0.5)
                    HStack {
                        Picker("", selection: $constant.axisMode) {
                            Text("Top").tag(ATAxisMode.top)
                            Text("Bottom").tag(ATAxisMode.bottom)
                            Text("Leading").tag(ATAxisMode.leading)
                            Text("Trailing").tag(ATAxisMode.trailing)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        Toggle("", isOn: $isPresented).labelsHidden()
                    }
                }
                Picker("", selection: $alignmentIndex) {
                    ForEach(Array(alignments.enumerated()), id:\.offset) { index, align in
                        Image(systemName: getAlignmentIcon(alignments[index])).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .zIndex(-1)
        }
        .font(.callout)
        .animation(.easeInOut, value: constant)
        .animation(.easeInOut, value: alignmentIndex)
        .padding()
    }
    
    private func getAlignmentIcon(_ alignment: Alignment) -> String {
        switch alignment {
        case .center: return "rectangle.center.inset.filled"
        case .leading: return "rectangle.leftthird.inset.filled"
        case .trailing: return "rectangle.rightthird.inset.filled"
        case .top: return "rectangle.topthird.inset.filled"
        case .bottom: return "rectangle.bottomthird.inset.filled"
        case .topLeading: return "rectangle.inset.topleft.filled"
        case .topTrailing: return "rectangle.inset.topright.filled"
        case .bottomLeading: return "rectangle.inset.bottomleft.filled"
        case .bottomTrailing: return "rectangle.inset.bottomright.filled"
        default:
            return ""
        }
    }
}

struct P232_AxisTooltip_Previews: PreviewProvider {
    static var previews: some View {
        P232_AxisTooltip()
    }
}
