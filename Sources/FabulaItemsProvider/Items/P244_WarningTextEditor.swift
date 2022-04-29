//
//  P244_WarningTextEditor.swift
//  
//
//  Created by jasu on 2022/04/29.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P244_WarningTextEditor: View {
    
    @State private var interval: CGFloat = 0
    
    @State private var limitNumber: Int = 30
    @State private var baseText: String = "Text"
    
    public init() {}
    public var body: some View {
        let text = Binding(
            get: { self.baseText },
            set: {
                if $0.count > limitNumber {
                    interval += 1
                }
                self.baseText = String($0.prefix(limitNumber)).components(separatedBy: .newlines).joined() }
        )
        VStack {
            Text("Number of characters : \(text.wrappedValue.count)")
                .foregroundColor(text.wrappedValue.count == limitNumber ? .red : .fabulaForeWB100)
            Rectangle()
                .fill(Color.fabulaFore2)
                .overlay(
                    TextEditor(text: text)
                        .padding(1)
                )
                .warning(interval)
        }
        .padding()
    }
}

struct P244_WarningTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        P244_WarningTextEditor()
    }
}

fileprivate
extension View {
    func warning(_ interval: CGFloat) -> some View {
        self.modifier(WarningEffect(interval))
            .animation(Animation.default, value: interval)
    }
}

fileprivate
struct WarningEffect: GeometryEffect {
    
    var animatableData: CGFloat
    var amount: CGFloat = 3
    var shakeCount = 6
    
    init(_ interval: CGFloat) {
        self.animatableData = interval
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * CGFloat(shakeCount) * .pi), y: 0))
    }
}
