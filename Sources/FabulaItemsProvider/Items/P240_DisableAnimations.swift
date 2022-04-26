//
//  P240_DisableAnimations.swift
//  
//
//  Created by jasu on 2022/04/26.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

struct P240_DisableAnimations: View {
    
    @State private var toggle: Bool = true
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.blue)
                    .border(.white, width: 2)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text("ON")
                            .font(.caption)
                            .bold()
                            .foregroundColor(Color.white)
                    )
                    .offset(x: toggle ? 0 : proxy.size.width - 40)
                Rectangle()
                    .fill(Color.red)
                    .border(.white, width: 2)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text("OFF")
                            .font(.caption)
                            .bold()
                            .foregroundColor(Color.white)
                    )
                    .offset(x: toggle ? 0 : proxy.size.width - 40)
                    .transaction { transaction in
                        transaction.animation = nil
                        // transaction.animation = .spring()
                    }
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Toggle")
                        .onTapGesture {
                            toggle.toggle()
                        }
                    Spacer()
                }
                Spacer()
            }
        }
        .padding()
        .animation(.easeInOut, value: toggle)
    }
}

struct P240_DisableAnimations_Previews: PreviewProvider {
    static var previews: some View {
        P240_DisableAnimations()
    }
}
