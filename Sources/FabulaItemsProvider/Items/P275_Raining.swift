//
//  P275_Raining.swift
//  
//
//  Created by tgeisse on 11/30/22.
//

import SwiftUI

public struct P275_Raining: View {
    public init() { }
    
    public var body: some View {
        Raining()
    }
}

fileprivate struct Raining: View {
    @State private var raindrops: [FallingRaindrops] = []
    
    var body: some View {
            ZStack {
                ForEach(raindrops) {
                    $0.raindrop
                }
            }
            .ignoresSafeArea()
            .onAppear {
                startRaining()
            }
    }
    
    private func startRaining() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .random(in: 0.03...0.15)) {
            addRaindrop()
            startRaining()
        }
    }
    
    private func addRaindrop() {
        let newRaindropId = UUID()
        let scale = Double.random(in: 0.7...1.3)
        let fallDuration = 3 / scale
        
        let raindrop = FallingRaindrop(scale: scale,
                                       animationDuration: fallDuration)
        
        raindrops.append(FallingRaindrops(id: newRaindropId,
                                          raindrop: raindrop))
        
        removeRaindrop(id: newRaindropId, after: fallDuration + 0.1)
    }
    
    private func removeRaindrop(id: UUID, after: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            guard let raindropPosition = raindrops.firstIndex(where: { $0.id == id }) else { return }
            
            raindrops.remove(at: raindropPosition)
        }
    }
}

fileprivate struct FallingRaindrops: Identifiable {
    let id: UUID
    let raindrop: FallingRaindrop
}

fileprivate struct FallingRaindrop: View {
    let scale: Double
    let animationDuration: Double
    
    private let offsetXRatio: Double = .random(in: 0.01...0.99)
    @State private var offsetYRatio: Double = -0.2
    
    var body: some View {
        GeometryReader { screen in
            Raindrop()
                .frame(width: 16 * scale, height: 32 * scale)
                .offset(x: screen.size.width * offsetXRatio,
                        y: screen.size.height * offsetYRatio)
                .onAppear {
                    withAnimation(.linear(duration: animationDuration)) {
                        offsetYRatio = 1.2
                    }
                }
        }
    }
}

/***********************************************/
/**     Borrowed from other Fabula items.     **/
/***********************************************/

// from P274_RaindropShape
fileprivate struct Raindrop: View {
    var body: some View {
        RaindropShape()
            .fill(LinearGradient(colors: [.blue.opacity(0.2), .blue], startPoint: .top, endPoint: .bottom))
    }
}

// from P274_RaindropShape
fileprivate struct RaindropShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let raindropBottomStart = rect.height * 0.8
        let midX = rect.width / 2
        let midY = rect.height / 2
        
        path.move(to: CGPoint(x: midX, y: 0))
        
        path.addCurve(to: CGPoint(x: 0, y: raindropBottomStart),
                      control1: CGPoint(x: midX - midX / 4, y: rect.height / 4),
                      control2: CGPoint(x: 0, y: midY))
        
        path.addQuadCurve(to: CGPoint(x: midX, y: rect.height),
                          control: CGPoint(x: 0, y: rect.height))
        
        path.addQuadCurve(to: CGPoint(x: rect.width, y: raindropBottomStart),
                          control: CGPoint(x: rect.width, y: rect.height))
        
        path.addCurve(to: CGPoint(x: midX, y: 0),
                      control1: CGPoint(x: rect.width, y: midY),
                      control2: CGPoint(x: midX + midX / 4, y: rect.height / 4))

        return path
    }
}

struct P275_Raining_Previews: PreviewProvider {
    static var previews: some View {
        P275_Raining()
    }
}
