//
//  P102_ScenePhase.swift
//  Fabula
//
//  Created by jasu on 2021/11/13.
//

import SwiftUI

public struct P102_ScenePhase: View {
    
    @Environment(\.scenePhase) var scenePhase
    @State private var state: String = "Active"
    
    public init() {}
    public var body: some View {
        VStack {
            Text("scenePhase")
                .font(.callout)
                .opacity(0.5)
            Text(state)
                .multilineTextAlignment(.center)
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                state += "\nInactive"
            } else if newPhase == .active {
                state += "\nActive"
            } else if newPhase == .background {
                state += "\nBackground"
            }
        }
    }
}

struct P102_ScenePhase_Previews: PreviewProvider {
    static var previews: some View {
        P102_ScenePhase()
    }
}
