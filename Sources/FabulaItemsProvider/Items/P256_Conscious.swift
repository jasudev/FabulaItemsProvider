//
//  P256_Conscious.swift
//  
//
//  Created by jasu on 2022/05/24.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P256_Conscious: View {
    
    @StateObject private var dragStore = DragStore()
    
    private var drag: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged { value in
                let t = value.translation
                let a = Double(t.width == 0 ? 0.0001 : t.width)
                let b = Double(t.height)
                
                let ang = a < 0 ? atan(Double(b / a)) : atan(Double(b / a)) - Double.pi
                dragStore.angle = Angle(radians: ang)
                dragStore.offset = value.translation
            }
            .onEnded { value in
                dragStore.angle = .zero
                dragStore.offset = .zero
            }
    }
    
    public init() {}
    public var body: some View {
        ZStack {
            VStack(spacing: 30) {
                HStack(spacing: 30) {
                    bothEyesView()
                    bothEyesView()
                    bothEyesView()
                }
                HStack(spacing: 30) {
                    bothEyesView()
                    bothEyesView()
                    bothEyesView()
                }
                HStack(spacing: 120) {
                    bothEyesView()
                    bothEyesView()
                }
                HStack(spacing: 30) {
                    bothEyesView()
                    bothEyesView()
                    bothEyesView()
                }
                HStack(spacing: 30) {
                    bothEyesView()
                    bothEyesView()
                    bothEyesView()
                }
            }
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .foregroundColor(Color.fabulaPrimary)
                .frame(width: 60, height: 60)
                .offset(dragStore.offset)
                .gesture(drag)
                .animation(.spring(), value: dragStore.offset)
                .animation(.spring(), value: dragStore.angle)
        }
        .environmentObject(dragStore)
    }
    
    private func bothEyesView() -> some View {
        BothEyesView()
    }
}

fileprivate
struct BothEyesView: View {
    var body: some View {
        HStack(spacing: 3) {
            EyeView()
            EyeView()
        }
    }
}

fileprivate
struct EyeView: View {
    
    @EnvironmentObject private var dragStore: DragStore
    @State private var isBlink: Bool = false
    var timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    init() {
        self.timer = Timer.publish(every: TimeInterval(Int.random(in: 1...10)), on: .main, in: .common).autoconnect()
    }
    var body: some View {
        Ellipse()
            .fill(Color.fabulaFore1)
            .frame(width: 30, height: 46)
            .scaleEffect(CGSize(width: 1, height: isBlink ? 0 : 1))
            .overlay(
                GeometryReader { proxy in
                    let circleSize: CGFloat = proxy.minSize / 2
                    ZStack {
                        Color.clear
                        Circle().fill(Color.fabulaBack0)
                            .frame(width: circleSize, height: circleSize)
                            .offset(x: dragStore.offset.width * 0.03, y: dragStore.offset.height * 0.03)
                    }
                }
            )
            .onReceive(timer, perform: { t in
                withAnimation(.easeInOut(duration: Double.random(in: 0.16...0.46))) {
                    isBlink.toggle()
                }
            })
            .mask(
                Ellipse()
                    .frame(width: 30, height: 46)
                    .scaleEffect(CGSize(width: 1, height: isBlink ? 0 : 1))
            )
    }
}

fileprivate
class DragStore: ObservableObject {
    @Published var angle: Angle = .zero
    @Published var offset: CGSize = .zero
}

struct P256_Conscious_Previews: PreviewProvider {
    static var previews: some View {
        P256_Conscious()
    }
}
