//
//  P72_RedactionReasons.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P72_RedactionReasons: View {
    
    public init() {}
    public var body: some View {
        VStack(spacing: 30) {
            Text("Hello, World")
                .redacted(reason: nil)
            Divider()
                .frame(width: 50)
            Text("Hello, World")
                .redacted(reason: .blur)
            Text("Hello, World")
                .redacted(reason: .yellow)
            Text("Hello, World")
                .redacted(reason: .line)
        }
    }
}

fileprivate
enum RedactionReason {
    case blur
    case yellow
    case line
}

fileprivate
struct Yellow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .opacity(0)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.yellow)
                    .padding(.vertical, 4.5)
            )
    }
}

fileprivate
struct Line: ViewModifier {
    func body(content: Content) -> some View {
        content
            .opacity(0)
            .overlay(
                Rectangle()
                    .frame(height: 1)
            )
    }
}

fileprivate
struct Blur: ViewModifier {
    func body(content: Content) -> some View {
        content
            .blur(radius: 6, opaque: false)
    }
}

fileprivate
extension View {
    func redacted(reason: RedactionReason?) -> some View {
        modifier(Redactable(reason: reason))
    }
}

fileprivate
struct Redactable: ViewModifier {
    
    let reason: RedactionReason?
    
    func body(content: Content) -> some View {
        switch reason {
        case .blur: content.modifier(Blur())
        case .yellow: content.modifier(Yellow())
        case .line: content.modifier(Line())
        default: content
        }
    }
}

struct P72_RedactionReasons_Previews: PreviewProvider {
    static var previews: some View {
        P72_RedactionReasons()
    }
}
