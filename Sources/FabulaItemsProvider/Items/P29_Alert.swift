//
//  P29_Alert.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P29_Alert: View {
    
    @State private var isShowAlert: Bool = false
    
    public init() {}
    public var body: some View {
        Button {
            isShowAlert = true
        } label: {
            Text("Show Alert")
        }
        .buttonStyle(FabulaButtonStyle())
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("Title"), message: Text("This is a alert message"), dismissButton: .default(Text("Dismiss")))
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

fileprivate
struct FabulaButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button {
            print("ddd")
        } label: {
            Text("Button")
        }
        .buttonStyle(FabulaButtonStyle())
        
        Button {
            print("ddd")
        } label: {
            Text("Button")
        }
        .buttonStyle(FabulaButtonStyle())
        .preferredColorScheme(.dark)
    }
}

struct P29_Alert_Previews: PreviewProvider {
    static var previews: some View {
        P29_Alert()
    }
}
