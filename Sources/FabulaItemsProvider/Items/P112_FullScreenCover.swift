//
//  P112_FullScreenCover.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P112_FullScreenCover: View {
    
    @State private var isShow = false
    
    public init() {}
    public var body: some View {
        Button("Present Full-Screen Cover") {
            isShow.toggle()
        }
#if os(iOS)
        .fullScreenCover(isPresented: $isShow, onDismiss: didDismiss) {
            VStack {
                Text("A full-screen modal view.")
                    .font(.title)
                Button {
                    isShow.toggle()
                } label: {
                    Text("Dismiss")
                }
            }
        }
#endif
    }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}

struct P112_FullScreenCover_Previews: PreviewProvider {
    static var previews: some View {
        P112_FullScreenCover()
    }
}
