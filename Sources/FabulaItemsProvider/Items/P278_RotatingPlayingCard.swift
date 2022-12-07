//
//  P279_RotatingPlayingCard.swift
//  
//
//  Created by tgeisse on 12/6/22.
//

import SwiftUI

public struct P278_RotatingPlayingCard: View {
    public init() { }
    
    public var body: some View {
        RotatingCard()
    }
}

fileprivate enum CardDisplaySide {
    case front
    case back
}

fileprivate struct RotatingCard: View {
    @State private var rotationAngle: Double = 0
    @State private var flippingAngle: Double = 0
    @State private var displaySide = CardDisplaySide.back
    
    var body: some View {
        VStack {
            RenderCard(displaySide: displaySide)
                .modifier(FlippingAnimation(angle: flippingAngle,
                                            displaySide: $displaySide))
                .modifier(RotatingAnimation(angle: rotationAngle))
                .onAppear {
                    withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                        flippingAngle = 360
                    }
                    
                    withAnimation(.linear(duration: 12).repeatForever(autoreverses: false)) {
                        rotationAngle = 360
                    }
                }
        }
    }
}

fileprivate struct RotatingAnimation: Animatable, ViewModifier {
    var angle: Double
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(angle))
    }
}

fileprivate struct FlippingAnimation: Animatable, ViewModifier {
    var angle: Double
    @Binding var displaySide: CardDisplaySide
    
    var animatableData: Double {
        get { angle }
        set {  angle = newValue }
    }
    
    func body(content: Content) -> some View {
        // So that the view is not modified while being drawn, DispatchQueue is used
        DispatchQueue.main.async {
            if 90 <= self.angle && self.angle <= 270 { self.displaySide = .front }
            else { self.displaySide = .back }
        }
        
        return content
            .rotation3DEffect(.degrees(angle),
                              axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}

fileprivate struct RenderCard: View {
    let displaySide: CardDisplaySide
    
    var body: some View {
        Group {
            if displaySide == .back {
                DiamondBack()
            } else {
                CardFront()
            }
        }
        .frame(width: 200, height: 280)
        .background(RoundedRectangle(cornerRadius: 5)
            .fill(.white)
            .shadow(radius: 5)
        )
    }
}

fileprivate struct CardFront: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray)
            
            RandomShape()
                .fill(Color.random)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .shadow(radius: 3)
                .padding(40)
        }
    }
}

fileprivate struct DiamondBack: View {
    private let backColor = [Color.red, .blue, .black.opacity(0.7)].randomElement()!
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray)
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(backColor, lineWidth: 5)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(backColor, lineWidth: 2)
                        .background(
                            DiamondFill()
                                .stroke(.white, lineWidth: 2)
                                .background(backColor)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        )
                        .padding(8)
                )
                .padding(1)
        }
    }
}

fileprivate struct DiamondFill: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let traveling = rect.width + rect.height
        
        for loc in stride(from: 10.0, through: traveling, by: 18) {
            let forwardXStart = loc <= rect.width ? loc : rect.width
            let forwardYStart = loc <= rect.width ? 0 : loc - rect.width
            let forwardXEnd = loc <= rect.height ? 0 : loc - rect.height
            let forwardYEnd = loc <= rect.height ? loc : rect.height
            
            let backwardXStart = loc <= rect.width ? loc : rect.width
            let backwardYStart = loc <= rect.width ? rect.height : rect.height - (loc - rect.width)
            let backwardXEnd = loc <= rect.height ? 0 : loc - rect.height
            let backwardYEnd = loc <= rect.height ? rect.height - loc : 0
            
            path.move(to: CGPoint(x: forwardXStart, y: forwardYStart))
            path.addLine(to: CGPoint(x: forwardXEnd, y: forwardYEnd))
            
            path.move(to: CGPoint(x: backwardXStart, y: backwardYStart))
            path.addLine(to: CGPoint(x: backwardXEnd, y: backwardYEnd))
        }
        
        return path
    }
}

/***********************************************/
/**     Borrowed from other Fabula items.     **/
/***********************************************/

// from P273_ShapeGenerator
fileprivate struct RandomShape: Shape {
    private var theShape: (any Shape)?
    
    private lazy var rectangle: RoundedRectangle = { RoundedRectangle(cornerRadius: 20) }()
    private lazy var circle: Circle = { Circle() }()
    private lazy var capsule: Capsule = { Capsule(style: .circular) }()
    private lazy var star5: Star = { Star(count: 5, innerRatio: 1) }()
    private lazy var star10: Star = { Star(count: 10, innerRatio: 1) }()
    private lazy var ellipse: Ellipse = { Ellipse() }()
    private lazy var raindrop: RaindropShape = { RaindropShape() }()
    
    init() {
        switch Int.random(in: 0..<7) {
        case 0: theShape = rectangle
        case 1: theShape = circle
        case 2: theShape = capsule
        case 3: theShape = star5
        case 4: theShape = star10
        case 5: theShape = raindrop
        default: theShape = ellipse
        }
    }
    
    func path(in rect: CGRect) -> Path {
        theShape!.path(in: rect)
    }
}

// from P229_StarShape
fileprivate
struct Star: Shape {
    
    var count: CGFloat
    var innerRatio: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(count, innerRatio) }
        set {
            count = newValue.first
            innerRatio = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let pointAngle = .pi / count
        
        let innerPoint = CGPoint(x: center.x * innerRatio * 0.5, y: center.y * innerRatio * 0.5)
        let totalPoints = Int(count * 2.0)
        
        var currentAngle = CGFloat.pi * -0.5
        var currentBottom: CGFloat = 0
        
        var path = Path()
        path.move(to: CGPoint(x: center.x * cos(currentAngle),
                              y: center.y * sin(currentAngle)))
        
        let correction = count != round(count) ? 1 : 0
        for corner in 0..<totalPoints + correction  {
            var bottom: CGFloat = 0
            let sin = sin(currentAngle)
            let cos = cos(currentAngle)
            if (corner % 2) == 0 {
                bottom = center.y * sin
                path.addLine(to: CGPoint(x: center.x * cos, y: bottom))
            } else {
                bottom = innerPoint.y * sin
                path.addLine(to: CGPoint(x: innerPoint.x * cos, y: bottom))
            }
            currentBottom = max(bottom, currentBottom)
            currentAngle += pointAngle
        }
        
        let transform = CGAffineTransform(translationX: center.x, y: center.y + ((rect.height * 0.5 - currentBottom) * 0.5))
        return path.applying(transform)
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

struct P278_RotatingPlayingCard_Previews: PreviewProvider {
    static var previews: some View {
        P278_RotatingPlayingCard()
    }
}
