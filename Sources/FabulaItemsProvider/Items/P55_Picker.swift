//
//  P55_Picker.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P55_Picker: View {
    
    enum PickerStyleType {
        case defaultPickerStyle
        case inlinePickerStyle
        case menuPickerStyle
        case segmentedPickerStyle
#if os(iOS)
        case wheelPickerStyle
#else
        case radioGroupPickerStyle
#endif
    }
    
    @State var currentStyleType: PickerStyleType = .defaultPickerStyle
    
    var styleName: String {
        switch currentStyleType {
        case .defaultPickerStyle:
            return "DefaultPickerStyle()"
        case .inlinePickerStyle:
            return "InlinePickerStyle()"
        case .menuPickerStyle:
            return "MenuPickerStyle()"
        case .segmentedPickerStyle:
            return "SegmentedPickerStyle()"
#if os(iOS)
        case .wheelPickerStyle:
            return "WheelPickerStyle()"
#else
        case .radioGroupPickerStyle:
            return "RadioGroupPickerStyle()"
#endif
        }
    }
    
    var pickerView: some View {
        Picker("My Picker", selection: $currentStyleType) {
            Text("DefaultPickerStyle()")
                .tag(PickerStyleType.defaultPickerStyle)
            Text("InlinePickerStyle()")
                .tag(PickerStyleType.inlinePickerStyle)
            Text("MenuPickerStyle()")
                .tag(PickerStyleType.menuPickerStyle)
            Text("SegmentedPickerStyle()")
                .tag(PickerStyleType.segmentedPickerStyle)
#if os(iOS)
            Text("WheelPickerStyle()")
                .tag(PickerStyleType.wheelPickerStyle)
#else
            Text("RadioGroupPickerStyle()")
                .tag(PickerStyleType.radioGroupPickerStyle)
#endif
        }
    }
    
    public init() {}
    public var body: some View {
        GroupBox {
            VStack {
                Text("Select Item : \(styleName)")
                Divider()
                switch currentStyleType {
                case .defaultPickerStyle:
                    pickerView.pickerStyle(DefaultPickerStyle())
                case .inlinePickerStyle:
                    pickerView.pickerStyle(InlinePickerStyle())
                case .menuPickerStyle:
                    pickerView.pickerStyle(MenuPickerStyle())
                case .segmentedPickerStyle:
                    pickerView.pickerStyle(SegmentedPickerStyle())
#if os(iOS)
                case .wheelPickerStyle:
                    pickerView.pickerStyle(WheelPickerStyle())
#else
                case .radioGroupPickerStyle:
                    pickerView.pickerStyle(RadioGroupPickerStyle())
#endif
                }
            }
        } label: {
            Text("Picker Style")
                .font(.caption)
                .opacity(0.5)
                .padding()
        }
        .frame(maxWidth: 500)
        .padding()
    }
}

struct P55_Picker_Previews: PreviewProvider {
    static var previews: some View {
        P55_Picker()
    }
}
