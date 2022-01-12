//
//  P200_DynamicTypeSize.swift
//  
//
//  Created by jasu on 2022/01/13.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

struct P200_DynamicTypeSize: View {
    
    var body: some View {
        if #available(macOS 12.0, *) {
            DynamicTypeSizeView()
        } else {
            Text("@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)")
        }
    }
}

@available(macOS 12.0, *)
fileprivate
struct DynamicTypeSizeView: View {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @State private var currentTypeSize: DynamicTypeSize = .xSmall
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("System : ").font(.caption).foregroundColor(Color.fabulaFore2)
                Text("\(dynamicTypeSize.name)")
                Spacer().frame(height: 20)
                Text("Current : ").font(.caption).foregroundColor(Color.fabulaFore2)
                Text("\(currentTypeSize.name)")
                    .dynamicTypeSize(currentTypeSize)
            }
            .frame(height: 200)
            
            Divider()
            Picker("DynamicTypeSize", selection: $currentTypeSize) {
                Group {
                    Text(DynamicTypeSize.xSmall.name).tag(DynamicTypeSize.xSmall)
                    Text(DynamicTypeSize.small.name).tag(DynamicTypeSize.small)
                    Text(DynamicTypeSize.medium.name).tag(DynamicTypeSize.medium)
                    Text(DynamicTypeSize.large.name).tag(DynamicTypeSize.large)
                    Text(DynamicTypeSize.xLarge.name).tag(DynamicTypeSize.xLarge)
                    Text(DynamicTypeSize.xxLarge.name).tag(DynamicTypeSize.xxLarge)
                    Text(DynamicTypeSize.xxxLarge.name).tag(DynamicTypeSize.xxxLarge)
                }
                Group {
                    Text(DynamicTypeSize.accessibility1.name).tag(DynamicTypeSize.accessibility1)
                    Text(DynamicTypeSize.accessibility2.name).tag(DynamicTypeSize.accessibility2)
                    Text(DynamicTypeSize.accessibility3.name).tag(DynamicTypeSize.accessibility3)
                    Text(DynamicTypeSize.accessibility4.name).tag(DynamicTypeSize.accessibility4)
                    Text(DynamicTypeSize.accessibility5.name).tag(DynamicTypeSize.accessibility5)
                }
            }
            .pickerStyle(InlinePickerStyle())
        }
        .padding()
    }
}

@available(macOS 12.0, *)
fileprivate
extension DynamicTypeSize {
    var name: String {
        switch self {
        case .xSmall: return "xSmall"
        case .small: return "small"
        case .medium: return "medium"
        case .large: return "large"
        case .xLarge: return "xLarge"
        case .xxLarge: return "xxLarge"
        case .xxxLarge: return "xxxLarge"
        case .accessibility1: return "accessibility1"
        case .accessibility2: return "accessibility2"
        case .accessibility3: return "accessibility3"
        case .accessibility4: return "accessibility4"
        case .accessibility5: return "accessibility5"
        @unknown default: return "Unknown"
        }
    }
}

struct P200_DynamicTypeSize_Previews: PreviewProvider {
    static var previews: some View {
        P200_DynamicTypeSize()
    }
}
