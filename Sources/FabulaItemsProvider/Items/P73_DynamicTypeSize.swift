//
//  P73_DynamicTypeSize.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

#if os(iOS)
public struct P73_DynamicTypeSize: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize: DynamicTypeSize
    @State private var currentTypeSize: DynamicTypeSize = .xSmall
    let types: [DynamicTypeSize] = [.xSmall, .small, .medium, .large, .xLarge, .xxLarge, .xxxLarge, .accessibility1, .accessibility2, .accessibility3, .accessibility4, .accessibility5]
    
    public init() {}
    public var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top, spacing: 8) {
                    VStack(alignment: .center) {
                        DynamicTypeSizeView()
                        Divider().frame(width: 44)
                        Text("Settings\n-> Display & Brightness\n-> Text Size")
                            .font(.caption)
                            .opacity(0.5)
                    }
                    Divider()
                    VStack(alignment: .center) {
                        DynamicTypeSizeView()
                            .environment(\.dynamicTypeSize, currentTypeSize)
                    }
                }
                Picker("Dynamic Type Size", selection: $currentTypeSize) {
                    ForEach(types, id:\.self) { type in
                        Text(type.typeName())
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
            }
        }
    }
}

fileprivate
extension DynamicTypeSize {
    func typeName() -> String {
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
        default: return ""
        }
    }
}

fileprivate
struct DynamicTypeSizeView: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize: DynamicTypeSize
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("." + dynamicTypeSize.typeName())
                .foregroundColor(Color.fabulaPrimary)
            VStack(alignment: .center, spacing: 8.0) {
                Group {
                    Text("largeTitle")
                        .font(.largeTitle)
                    Text("Title")
                        .font(.title)
                    Text("Title 2")
                        .font(.title2)
                    Text("Title 3")
                        .font(.title3)
                    Text("Headline")
                        .font(.headline)
                    Text("Subheadline")
                        .font(.subheadline)
                    Text("Body")
                        .font(.body)
                    Text("Callout")
                        .font(.callout)
                    Text("Footnote")
                        .font(.footnote)
                    Text("Caption")
                        .font(.caption)
                }
                Text("Caption 2")
                    .font(.caption2)
            }
        }
        .padding()
    }
}

#else
public struct P73_DynamicTypeSize: View {
    
    public init() {}
    public var body: some View {
        EmptyView()
    }
}
#endif

struct P73_DynamicTypeSize_Previews: PreviewProvider {
    static var previews: some View {
        P73_DynamicTypeSize()
    }
}
