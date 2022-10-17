//
//  P266_ViscosityCanvas.swift
//  
//
//  Created by jasu on 2022/10/17.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P266_ViscosityCanvas: View {

    @State private var scale1: CGFloat = 1
    @State private var scale2: CGFloat = 1
    @State private var isFillMode: Bool = true
    
    public init() {}
    public var body: some View {
        ZStack {
            viscosityView(color: Color.fabulaPrimary, scale: $scale1)
            viscosityView(color: Color.fabulaSecondary, scale: $scale2)
                .blendMode(.screen)
            
            Toggle(isOn: $isFillMode) {
                EmptyView()
            }
            .labelsHidden()
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func viscosityView(color: Color, scale: Binding<CGFloat>) -> some View {
        GeometryReader { geo in
            if isFillMode {
                ViscosityCanvas(color: color) {
                    circle(cnavasSize: geo.size, scale: scale)
                }
            } else {
                ViscosityCanvas(color: color, thresholdMin: 0.5, thresholdMax: 0.7) {
                    circle(cnavasSize: geo.size, scale: scale)
                }
            }
        }
    }
    
    @ViewBuilder
    private func circle(cnavasSize: CGSize, scale: Binding<CGFloat>) -> some View {
        let min = min(cnavasSize.width, cnavasSize.height) * 0.09
        let width: CGFloat = .random(in: min...(min * 2.6))
        let height: CGFloat = .random(in: min...(min * 2.6))
        
        ForEach(0..<60, id: \.self) { index in
            Circle()
                .frame(width: width, height: height)
                .scaleEffect(scale.wrappedValue * .random(in: 0.1..<1.5))
                .animation(Animation.easeInOut(duration: 3)
                    .repeatForever()
                    .speed(.random(in: 0.2...1.0))
                    .delay(.random(in: 0...2)), value: scale.wrappedValue)
                .position(CGPoint(x: .random(in: 0..<cnavasSize.width),
                                  y: .random(in: 0..<cnavasSize.height)))
                .tag(index)
        }
        .onAppear {
            scale.wrappedValue = scale.wrappedValue == 1.2 ? 1.0 : 1.2
        }
    }
}

fileprivate
struct ViscosityCanvas<Symbols: View> : View {
    
    let color: Color
    let thresholdMin: CGFloat
    let thresholdMax: CGFloat?
    let radius: CGFloat
    let symbols: () -> Symbols
    
    var body: some View {
        Canvas { context, size in
            if let thresholdMax = thresholdMax {
                context.addFilter(.alphaThreshold(min: thresholdMin, max: thresholdMax, color: color))
            } else {
                context.addFilter(.alphaThreshold(min: thresholdMin, color: color))
            }
            context.addFilter(.blur(radius: 12))
            context.drawLayer { ctx in
                for index in 0..<60 {
                    if let view = context.resolveSymbol(id: index) {
                        ctx.draw(view, at: CGPoint(x: size.width / 2, y: size.height / 2))
                    }
                }
            }
        } symbols: {
            symbols()
        }
    }
    
    init(color: Color, thresholdMin: CGFloat = 0.5, thresholdMax: CGFloat? = nil, radius: CGFloat = 12, @ViewBuilder symbols: @escaping () -> Symbols) {
        self.color = color
        self.thresholdMin = thresholdMin
        self.thresholdMax = thresholdMax
        self.radius = radius
        self.symbols = symbols
    }
}

struct P266_ViscosityCanvas_Previews: PreviewProvider {
    static var previews: some View {
        P266_ViscosityCanvas()
    }
}
