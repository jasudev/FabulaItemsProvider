//
//  P260_PickerStyle.swift
//  
//
//  Created by jasu on 2022/06/01.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P260_PickerStyle: View {
    
    @State private var selection: Int = 0
    
    private var pickerStyleGroup: some View {
        Group {
            Text(".automatic").tag(0)
            Text(".inline").tag(1)
            Text(".menu").tag(2)
#if os(macOS)
            Text(".radioGroup").tag(3)
#endif
            Text(".segmented").tag(4)
#if os(iOS)
            Text(".wheel").tag(5)
#endif
        }
    }
    
    public init() {}
    public var body: some View {
        Form {
            Picker(".automatic", selection: self.$selection) {
                pickerStyleGroup
            }
            .pickerStyle(.automatic)
            
            Picker(".inline", selection: self.$selection) {
                pickerStyleGroup
            }
            .pickerStyle(.inline)
            
            Picker(".menu", selection: self.$selection) {
                pickerStyleGroup
            }
            .pickerStyle(.menu)
            
#if os(macOS)
            Picker(".radioGroup", selection: self.$selection) {
                pickerStyleGroup
            }
            .pickerStyle(.radioGroup)
#endif
            Picker(".segmented", selection: self.$selection) {
                pickerStyleGroup
            }
            .pickerStyle(.segmented)
            
#if os(iOS)
            Picker(".wheel", selection: self.$selection) {
                pickerStyleGroup
            }
            .pickerStyle(.wheel)
#endif
        }
#if os(macOS)
        .padding()
#endif
    }
}

struct P260_PickerStylePreviews: PreviewProvider {
    static var previews: some View {
        P260_PickerStyle()
    }
}
