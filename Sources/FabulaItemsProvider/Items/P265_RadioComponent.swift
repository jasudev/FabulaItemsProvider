//
//  P265_RadioComponent.swift
//  
//
//  Created by jasu on 2022/09/28.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P265_RadioComponent: View {
    
    enum AlignmentType: String {
        case horizontal
        case vertical
    }
    
    enum LayoutType: String {
        case front
        case behind
    }
    
    @State private var alignment: AlignmentType = .vertical
    @State private var layout: LayoutType = .front
    @State private var selection: Int? = 0
    @Namespace var namespace
    
    public init() {}
    public var body: some View {
        VStack {
            if let selection {
                Text("Value : \(selection)")
            }
            Divider().padding()
            radioContainer()
                .frame(height: 130)
            Divider().padding()
            buttons()
        }
#if os(iOS)
        .animation(.easeInOut, value: alignment)
        .animation(.easeInOut, value: layout)
#endif
        .padding()
    }
    
    private func radioContainer() -> some View {
        RadioComponent(selection: $selection) {
            if alignment == .vertical {
                VStack(spacing: 16) {
                    items()
                }
            } else {
                HStack(spacing: 16) {
                    items()
                }
            }
        } onTapReceive: { value in
            print(value ?? "nil")
        }
    }
    
    private func items() -> some View {
        ForEach(0..<4) { index in
            item(tag: index)
                .matchedGeometryEffect(id: "\(index)", in: namespace)
        }
    }
    
    private func item(tag: Int) -> some View {
        HStack(spacing: 0) {
            if layout == .front {
                RadioItem(tag: tag)
                    .matchedGeometryEffect(id: "icon\(tag)", in: namespace)
                Spacer()
                Text("Item \(tag)")
                    .font(.callout)
                    .opacity(0.6)
                    .matchedGeometryEffect(id: "title\(tag)", in: namespace)
            } else {
                Text("Item \(tag)")
                    .font(.callout)
                    .opacity(0.6)
                    .matchedGeometryEffect(id: "title\(tag)", in: namespace)
                Spacer()
                RadioItem(tag: tag)
                    .matchedGeometryEffect(id: "icon\(tag)", in: namespace)
            }
        }
        .contentShape(Rectangle())
        .frame(width: 70)
        .radioTag(tag)
    }
    
    private func buttons() -> some View {
        VStack(spacing: 16) {
            Button {
                alignment = alignment == .vertical ? .horizontal : .vertical
            } label: {
                Text("Change Direction")
            }
            Button {
                layout = layout == .front ? .behind : .front
            } label: {
                Text("Change the layout")
            }
        }
    }
}

//MARK: - RadioValue
fileprivate
class RadioValue<T: Hashable>: ObservableObject {
    typealias TapReceiveAction = (T?) -> Void
    
    @Binding var selection: T?
    var onTapReceive: (TapReceiveAction)?
    
    init(selection: Binding<T?>, onTapReceive: (TapReceiveAction)? = nil) {
        _selection = selection
        self.onTapReceive = onTapReceive
    }
}



//MARK: - RadioComponent
fileprivate
struct RadioComponent<T: Hashable, Content: View>: View {
    
    private let value: RadioValue<T>
    private let content: () -> Content
    
    var body: some View {
        content()
            .environmentObject(value)
    }
}

fileprivate
extension RadioComponent where T: Hashable, Content: View {
    init(selection: Binding<T?>, @ViewBuilder _ content: @escaping () -> Content) {
        self.value = RadioValue(selection: selection)
        self.content = content
    }
    
    init(selection: Binding<T?>, @ViewBuilder _ content: @escaping () -> Content, onTapReceive: ((T?) -> Void)?) {
        self.value = RadioValue(selection: selection, onTapReceive: onTapReceive)
        self.content = content
    }
}

//MARK: - RadioItem
fileprivate
struct RadioItem<T: Hashable>: View {
    
    @EnvironmentObject private var value: RadioValue<T>
    private var tag: T?
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
            Circle()
                .stroke()
                .fill(Color.black.opacity(0.2))
            if tag == value.selection {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 8, height: 8)
                    .transition(.scale)
            }
        }
        .frame(width: 16, height: 16)
        .animation(.easeInOut(duration: 0.2), value: value.selection)
    }
}

fileprivate
extension RadioItem where T: Hashable {
    init(tag: T) {
        self.tag = tag
    }
}

//MARK: - RadioItemModifier
fileprivate
struct RadioItemModifier<T: Hashable>: ViewModifier {
    @EnvironmentObject private var value: RadioValue<T>
    private var tag: T?
    
    func body(content: Content) -> some View {
        Button {
            value.selection = tag
            value.onTapReceive?(tag)
        } label: {
            content
        }
        .buttonStyle(.plain)
    }
}

fileprivate
extension RadioItemModifier where T: Hashable {
    init(_ tag: T?) {
        self.tag = tag
    }
}

fileprivate
extension View {
    func radioTag<T: Hashable>(_ tag: T?) -> some View {
        self.modifier(RadioItemModifier(tag))
    }
}


struct P265_RadioComponent_Previews: PreviewProvider {
    static var previews: some View {
        P265_RadioComponent()
    }
}
