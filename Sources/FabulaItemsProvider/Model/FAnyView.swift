//
//  FAnyView.swift
//  Fabula
//
//  Created by jasu on 2021/09/03.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct FAnyView: View {
    private let internalView: AnyView
    public let originalView: Any
    public init<V: View>(_ view: V) {
        internalView = AnyView(view)
        originalView = view
    }
    
    public var body: some View {
        internalView
    }
    
    public var viewName: String {
        return "\(type(of: self.originalView.self))"
    }
}

struct FAnyView_Previews: PreviewProvider {
    static var previews: some View {
        FAnyView(Text("test"))
    }
}
