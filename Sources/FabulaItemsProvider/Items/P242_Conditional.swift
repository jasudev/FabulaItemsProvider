//
//  P242_Conditional.swift
//  References : https://www.youtube.com/watch?v=1BHHybRnHFE
//
//  Created by jasu on 2022/04/28.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

struct P242_Conditional: View {
    
    @State private var showBackground: Bool = false
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .if(showBackground) {
                    $0.background(Color.fabulaPrimary)
                }
                .padding()
                .background(Color.fabulaFore2.opacity(0.5))
            Button {
                showBackground.toggle()
            } label: {
                Text("Toggle")
            }
        }
    }
}

struct P242_Conditional_Previews: PreviewProvider {
    static var previews: some View {
        P242_Conditional()
    }
}

fileprivate
extension View {
    func `if`<T: View>(_ conditional: Bool, transform: (Self) -> T) -> some View {
        Group {
            if conditional {
                transform(self)
            } else { self }
        }
    }
    
    func `if`<T: View>(_ condition: Bool, true trueTransform: (Self) -> T, false falseTransform: (Self) -> T) -> some View {
        Group {
            if condition {
                trueTransform(self)
            } else {
                falseTransform(self)
            }
        }
    }
}
