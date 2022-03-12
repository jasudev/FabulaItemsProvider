//
//  P225_LottieUI.swift
//  
//  Package : https://github.com/jasudev/LottieUI.git
//  Created by jasu on 2022/02/13.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import LottieUI

public struct P225_LottieUI: View {
    
    let state1 = LUStateData(type: .loadedFrom(URL(string: "https://assets5.lottiefiles.com/packages/lf20_rjgikbck.json")!), speed: 1.0, loopMode: .loop)
    let state2 = LUStateData(type: .loadedFrom(URL(string: "https://assets9.lottiefiles.com/packages/lf20_mniampqn.json")!), speed: 1.0, loopMode: .loop)
    let state3 = LUStateData(type: .loadedFrom(URL(string: "https://assets10.lottiefiles.com/packages/lf20_wdqlqkhq.json")!), speed: 1.0, loopMode: .loop)
    
    public init() {}
    public var body: some View {
        ScrollView {
            VStack {
                CustomStateView(state: state1)
                    .padding()
                    .background(Color.red.opacity(0.2))
                    .frame(height: 300)
                CustomStateView(state: state2)
                    .padding()
                    .background(Color.green.opacity(0.2))
                    .frame(height: 300)
                CustomStateView(state: state3)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .frame(height: 300)
            }
            .padding()
        }
    }
}

fileprivate
struct CustomStateView: View {
    
    @State private var value: CGFloat = 0
    let state: LUStateData
    
    @State private var completedText: String = ""
    @State private var downloadedText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Value : \(value)")
                Spacer()
                Text(downloadedText)
                Divider().frame(height: 16)
                Text(completedText)
            }
            .frame(height: 26)
            LottieView(state: state, value: value, onCompleted: { success in
                completedText = "Completed"
            }, onDownloaded: { success in
                downloadedText = "Downloaded"
            })
            Slider(value: $value, in: 0...1)
        }
        .font(.caption)
    }
}

struct P225_LottieUI_Previews: PreviewProvider {
    static var previews: some View {
        P225_LottieUI()
    }
}
