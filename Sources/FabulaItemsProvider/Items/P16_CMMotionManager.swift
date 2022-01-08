//
//  P16_CMMotionManager.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI
import CoreMotion

public struct P16_CMMotionManager: View {
#if os(iOS)
    let colors = [Color(hex: 0x1D427B), Color(hex: 0x285D99), Color(hex: 0x3476BA), Color(hex: 0x4091DA), Color(hex: 0x54A7E2), Color(hex: 0x71BDEB), Color(hex: 0x91D3F3), Color(hex: 0xB5E8FC)]
    @StateObject var motionManager: MotionManager = MotionManager()
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                ZStack {
                    ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                        Circle()
                            .fill(color)
                            .frame(width: proxy.minSize - 40.0 * CGFloat(index),
                                   height: proxy.minSize - 40.0 * CGFloat(index))
                            .modifier(Motion2DModifier(manager: motionManager,
                                                       magnitude: 60.0 * CGFloat(index) * 0.1))
                    }
                    .frame(width: proxy.minSize / 2, height: proxy.minSize / 2)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
                }
            }
            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 1)
        }
        .padding()
    }
#else
    public init() {}
    public var body: some View {
        EmptyView()
    }
#endif
}

extension P16_CMMotionManager {
    
    #if os(iOS)
    struct Motion2DModifier: ViewModifier {
        
        @ObservedObject var manager: MotionManager
        var magnitude: Double = 30.0
        
        func body(content: Content) -> some View {
            content
                .offset(x: CGFloat(manager.roll * magnitude), y: CGFloat(manager.pitch * magnitude))
        }
    }
    
    class MotionManager: ObservableObject {
        
        @Published var pitch: Double = 0.0
        @Published var roll: Double = 0.0
        
        var interval: CGFloat = 0.01
        
        private var manager: CMMotionManager
        
        init() {
            self.manager = CMMotionManager()
            self.manager.deviceMotionUpdateInterval = interval
            self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                
                if let motionData = motionData {
                    withAnimation {
                        self.pitch = motionData.attitude.pitch
                        self.roll = motionData.attitude.roll
                    }
                }
            }
        }
    }
    #endif
}


struct CMMotionManager_Previews: PreviewProvider {
    static var previews: some View {
        P16_CMMotionManager()
    }
}
