//
//  P111_Sheet.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P111_Sheet: View {
    
    @State private var isShowSheet = false
    
    public init() {}
    public var body: some View {
        Button(action: {
            isShowSheet.toggle()
        }) {
            Text("Show Sheet")
        }
        .sheet(isPresented: $isShowSheet,
               onDismiss: didDismiss) {
            SheetDetailView(isShowSheet: $isShowSheet)
        }
    }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}

fileprivate
struct SheetDetailView: View {
    
    @Binding var isShowSheet: Bool
    
    var body: some View {
        VStack {
            Text("Sheet Detail Screen")
                .font(.title)
                .padding(50)
            Button("Dismiss",
                   action: {
                isShowSheet.toggle()
                
            })
                .padding()
        }
    }
}

struct P111_Sheet_Previews: PreviewProvider {
    static var previews: some View {
        P111_Sheet()
    }
}
