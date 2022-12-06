//
//  P274_RaindropShape.swift
//  
//
//  Created by tgeisse on 11/30/22.
//

import SwiftUI

public struct P274_RaindropShape: View {
    public init() { }
    
    public var body: some View {
        Raindrop()
            .frame(width: 200, height: 400)
    }
}

fileprivate struct Raindrop: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RaindropShape()
                    .fill(LinearGradient(colors: [.blue.opacity(0.2), .blue],
                                         startPoint: .top,
                                         endPoint: .bottom))
                
                /* If you want to put a lightspot on the raindrop,
                   then you can uncomment this block of code
                 
                let width = geometry.size.width
                let height = geometry.size.height
                
                let widerThanTaller = width > height
                let offsetX = widerThanTaller ? 0 - width * 0.2 : 0 - width * 0.1
                let offsetY = widerThanTaller ? height * 0.2 : height * 0.25
                
                Ellipse()
                    .fill(.white)
                    .rotationEffect(.init(degrees: widerThanTaller ? -15.0: 15))
                    .frame(width: width * 0.25, height: height * 0.23)
                    .offset(x: offsetX, y: offsetY)
                    .blur(radius: width * 0.2)
                 
                 */
            }
        }
    }
}

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

struct P274_RaindropShape_Previews: PreviewProvider {
    static var previews: some View {
        P274_RaindropShape()
    }
}
