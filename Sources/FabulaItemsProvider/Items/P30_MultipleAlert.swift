//
//  P30_MultipleAlert.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P30_MultipleAlert: View {
    
    @State private var showAlert1: Bool = false
    @State private var showAlert2: Bool = false
    
    public init() {}
    public var body: some View {
        VStack(spacing: 16) {
            Button("Show Alert1") {
                showAlert1 = true
            }
            .buttonStyle(FabulaButtonStyle())
            .alert(isPresented: $showAlert1) {
                Alert(title: Text("Alert1"), message: Text("This is a alert message 1"), dismissButton: .default(Text("Dismiss")))
            }
            
            Button("Show Alert2") {
                showAlert2 = true
            }
            .buttonStyle(FabulaButtonStyle())
            .alert(isPresented: $showAlert2) {
                Alert(title: Text("Alert2"), message: Text("This is a alert2 message 2"), dismissButton: .default(Text("Dismiss")))
            }
        }
    }
}

fileprivate
struct FabulaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
#if os(iOS)
            .font(.callout)
#endif
            .padding(10)
            .background(Color.fabulaSecondary.opacity(0.7))
            .foregroundColor(Color.fabulaFore1)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
            .animation(.easeOut(duration: 0.05), value: configuration.isPressed)
        
    }
}
struct P30_MultipleAlert_Previews: PreviewProvider {
    static var previews: some View {
        P30_MultipleAlert()
    }
}
