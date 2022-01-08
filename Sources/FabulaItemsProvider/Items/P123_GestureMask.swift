//
//  P123_GestureMask.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P123_GestureMask: View {
    
    @State private var color = Color.blue
    @State private var currentMaskIndex: Int = 0
    
    var pickerItems: some View {
        Group {
            Text(GestureMaskName.all.rawValue).tag(0)
            Text(GestureMaskName.gesture.rawValue).tag(1)
            Text(GestureMaskName.subviews.rawValue).tag(2)
            Text(GestureMaskName.none.rawValue).tag(3)
        }
    }
    
    public init() {}
    public var body: some View {
        let tap = TapGesture()
            .onEnded { _ in
                withAnimation {
                    self.color = self.color == .blue ? .red : .blue
                }
            }
        return VStack {
            VStack {
                Spacer()
                ZStack {
                    Color.clear
                    Circle()
                        .foregroundColor(color)
                    SubviewGestureMask()
                }
                .gesture(tap, including: getMaskWithIndex(currentMaskIndex).0)
            }
            
            Divider().frame(width: 44).padding()
            
            VStack(alignment: .leading) {
                Text("Current GestureMask : \(getMaskWithIndex(currentMaskIndex).1)")
                    .font(.callout)
                Text(getMaskWithIndex(currentMaskIndex).2)
                    .font(.caption)
                    .opacity(0.5)
                Picker("Current Mask", selection: $currentMaskIndex) {
                    pickerItems
                }.pickerStyle(SegmentedPickerStyle())
            }
            Spacer()
        }
        .padding()
    }
}

fileprivate
enum GestureMaskName: String {
    case all = "all"
    case gesture = "gesture"
    case subviews = "subviews"
    case none = "none"
}

fileprivate
func getMaskWithIndex(_ index: Int) -> (GestureMask, String, String) {
    
    var gestureMask: GestureMask
    var maskName: String
    var description: String
    
    switch index {
    case 0:
        maskName = "all"
        gestureMask = GestureMask.all
        description = "Enable both the added gesture as well as all other gestures on the view and its subviews."
    case 1:
        maskName = "gesture"
        gestureMask = GestureMask.gesture
        description = "Enable the added gesture but disable all gestures in the subview hierarchy."
    case 2:
        maskName = "subviews"
        gestureMask = GestureMask.subviews
        description = "Enable all gestures in the subview hierarchy but disable the added gesture."
    case 3:
        maskName = "none"
        gestureMask = GestureMask.none
        description = "Disable all gestures in the subview hierarchy, including the added gesture."
    default:
        maskName = "all"
        gestureMask = GestureMask.all
        description = "Enable both the added gesture as well as all other gestures on the view and its subviews."
    }
    return (gestureMask, maskName, description)
}

fileprivate
struct SubviewGestureMask: View {
    
    @State private var color = Color.yellow
    
    var body: some View {
        let tap = TapGesture()
            .onEnded { _ in
                withAnimation {
                    self.color = self.color == .yellow ? .green : .yellow
                }
            }
        
        return GeometryReader { proxy in
            ZStack {
                Color.clear
                VStack {
                    Spacer()
                    Circle()
                        .foregroundColor(color)
                        .frame(width: proxy.size.width / 2, height: proxy.size.height / 2)
                        .gesture(tap)
                }
            }
        }
    }
}

struct P123_GestureMask_Previews: PreviewProvider {
    static var previews: some View {
        P123_GestureMask()
    }
}
