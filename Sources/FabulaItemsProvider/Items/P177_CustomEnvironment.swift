//
//  P177_CustomEnvironment.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P177_CustomEnvironment: View {
    
    public init() {}
    public var body: some View {
        RowView()
            .rowHeight(200)
    }
}

fileprivate
struct RowHeightKey: EnvironmentKey {
    static let defaultValue = 200.0
}

fileprivate
extension EnvironmentValues {
    var rowHeight: CGFloat {
        get { self[RowHeightKey.self] }
        set { self[RowHeightKey.self] = newValue }
    }
}

fileprivate
extension View {
    func rowHeight(_ value: CGFloat) -> some View {
        environment(\.rowHeight, value)
    }
}

fileprivate
extension P177_CustomEnvironment {
    struct RowView: View {
        
        @Environment(\.rowHeight) private var rowHeight
        
        var body: some View {
            Text("Hello, World!")
                .frame(width: rowHeight, height: rowHeight)
                .background(Color.fabulaPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct P177_CustomEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        P177_CustomEnvironment()
    }
}
