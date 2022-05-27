//
//  P249_DynamicProperty.swift
//  
//
//  Created by jasu on 2022/05/17.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P249_DynamicProperty: View {
    
    @SpaceState var text: String = "DynamicProperty"
    
    public init() {}
    public var body: some View {
        VStack {
            Text(text)
                .padding()
                .background(Color.fabulaFore1.opacity(0.1))
                .cornerRadius(8)
            Divider()
                .padding()
            Button("Set HELLO") {
                text = "HELLO"
            }
            Divider().frame(width: 44)
            Button("Set Hello world!") {
                text = "Hello world!"
            }
        }
    }
    
    @propertyWrapper
    struct SpaceState: DynamicProperty {
        @State private var spaceText: String = ""
        
        var wrappedValue: String {
            get { return spaceText }
            nonmutating set { spaceText = getAddedSpace(newValue) }
        }
        
        var projectedValue: Binding<String> {
            return Binding<String>(get: { return spaceText },
                                   set: { spaceText = getAddedSpace($0) }
            )
        }
        
        init(wrappedValue: String) {
            self._spaceText = State<String>(wrappedValue: getAddedSpace(wrappedValue))
        }
        
        private func getAddedSpace(_ text: String) -> String {
            return text.map { "\($0)" }.joined(separator: " ")
        }
    }
}

struct P249_DynamicProperty_Previews: PreviewProvider {
    static var previews: some View {
        P249_DynamicProperty()
    }
}
