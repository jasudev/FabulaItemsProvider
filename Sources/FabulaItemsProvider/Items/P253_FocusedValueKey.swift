//
//  P253_FocusedValueKey.swift
//  
//
//  Created by jasu on 2022/05/21.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P253_FocusedValueKey: View {
    
    public init() {}
    public var body: some View {
        ZStack {
            Color.fabulaBack1
                .dismissKeyboardOnTap()
            VStack {
                Text("Memo")
                    .font(.title)
                Spacer()
                MemoPreview()
                    .foregroundColor(.fabulaFore1)
                Divider()
                MemoEditor()
                Divider()
                MemoButtons()
                    .frame(height: 32)
                    .padding()
                Spacer()
            }
        }
    }
}

//MARK: - subview
fileprivate
struct MemoEditor: View {
    
    @State private var title = ""
    @State private var bodyText = ""
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .focusedValue(\.activeField, .title)
                .focusedValue(\.textValue, title)
                .focusedValue(\.textBinding, $title)
                .textFieldStyle(.roundedBorder)
            TextEditor(text: $bodyText)
                .focusedValue(\.activeField, .body)
                .focusedValue(\.textValue, bodyText)
                .focusedValue(\.textBinding, $bodyText)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke()
                        .fill(Color.fabulaFore1.opacity(0.1))
                )
        }
        .padding()
    }
}

fileprivate
struct MemoButtons: View {
    @FocusedBinding(\.textBinding) var text
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                text = ""
            } label: {
                Text("Clear Title")
                    .padding()
                    .background(Color.fabulaSecondary)
                    .cornerRadius(11)
            }
            .buttonStyle(.plain)
            Spacer()
        }
    }
}

fileprivate
struct MemoPreview: View {
    @FocusedValue(\.activeField) private var activeField
    @FocusedValue(\.textValue) private var text
    
    var body: some View {
        VStack {
            Group {
                if let activeField = activeField {
                    Text("\(activeField.rawValue) is focused.")
                        .bold()
                } else {
                    Text("Field is not focused.")
                }
            }
            .foregroundColor(.fabulaPrimary)
            Text(text ?? "")
        }
        .padding()
    }
}

//MARK: - enum
fileprivate
enum ActiveField: String {
    case title = "Title"
    case body = "Body"
}

//MARK: - FocusedValueKey
fileprivate
struct ActiveFieldKey : FocusedValueKey {
    typealias Value = ActiveField
}

fileprivate
struct FocusedMemoKey: FocusedValueKey {
    typealias Value = String
}

fileprivate
struct FocusedTextBinding: FocusedValueKey {
    typealias Value = Binding<String>
}

//MARK: - FocusedValues
fileprivate
extension FocusedValues {
    var textValue: FocusedMemoKey.Value? {
        get { self[FocusedMemoKey.self] }
        set { self[FocusedMemoKey.self] = newValue }
    }
    var activeField: ActiveFieldKey.Value? {
        get { self[ActiveFieldKey.self] }
        set { self[ActiveFieldKey.self] = newValue }
    }
    var textBinding: FocusedTextBinding.Value? {
        get { self[FocusedTextBinding.self] }
        set { self[FocusedTextBinding.self] = newValue }
    }
}

//MARK: - dismissKeyboard
fileprivate
struct DismissKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
#if os(macOS)
        return content
#else
        return content.gesture(tapGesture)
#endif
    }
    
    private var tapGesture: some Gesture {
        TapGesture().onEnded(endEditing)
    }
    
    private func endEditing() {
#if os(iOS)
        UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .map {$0 as? UIWindowScene}
            .compactMap({$0})
            .first?.windows
            .filter {$0.isKeyWindow}
            .first?.endEditing(true)
#endif
    }
}

fileprivate
extension View {
    func dismissKeyboardOnTap() -> some View {
        modifier(DismissKeyboardOnTap())
    }
}

struct P253_FocusedValueKey_Previews: PreviewProvider {
    static var previews: some View {
        P253_FocusedValueKey()
    }
}


