//
//  P273_ShapeGenerator.swift
//
//
//  Created by tgeisse on 11/28/22.
//

import SwiftUI

public struct P273_ShapeGenerator: View {
    
    public init() {}
    public var body: some View {
        SolarSystem()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

fileprivate struct SolarSystem: View {
    @State private var shapeViewItems: [SolarSystemItem] = []
    
    var body: some View {
        ZStack {
            ForEach(shapeViewItems) { item in
                item.view
            }
            
            VStack(spacing: 10) {
                Button("Add Shape") {
                    addSolarSystemItem()
                }
                
                Button("Remove Shape") {
                    removeSolarSystemItem()
                }
            }
            .buttonStyle(.bordered)
        }
    }
    
    private func addSolarSystemItem() {
        shapeViewItems.append(.init(view: SolarSystemShape()))
    }
    
    private func removeSolarSystemItem() {
        if shapeViewItems.isEmpty { return }
        shapeViewItems.remove(at: .random(in: 0..<shapeViewItems.count))
    }
}

fileprivate struct SolarSystemItem: Identifiable {
    var id = UUID()
    var view: SolarSystemShape
}

fileprivate struct SolarSystemShape: View {
    @State private var angle = Double.random(in: 0..<360)
    @State private var a = Double.random(in: 0.25...0.9)
    @State private var b = Double.random(in: 0.25...0.9)
    
    var body: some View {
        GeometryReader { proxy in
            ShapeView()
                .modifier(EllipseAnimation(angle: angle, proxy: proxy, a: a, b: b))
                .onAppear {
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                        angle += 360
                    }
                }
        }
    }
}

fileprivate struct EllipseAnimation: Animatable, ViewModifier {
    var angle: Double
    let proxy: GeometryProxy
    let a: Double
    let b: Double
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue.truncatingRemainder(dividingBy: 360) }
    }
    
    
    private var xOffset: Double {
        (a / 2) * cos(2 * (angle / 360) * .pi) + 0.5
    }
    
    private var yOffset: Double {
        (b / 2) * sin(2 * (angle / 360) * .pi) + 0.5
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: proxy.size.width * xOffset,
                    y: proxy.size.height * yOffset)
    }
}

fileprivate struct ShapeView: View {
    var body: some View {
        RandomShape()
            .fill(Color.random)
            .frame(width: 25, height: 25)
    }
}

fileprivate struct RandomShape: Shape {
    private var theShape: (any Shape)?
    
    private lazy var rectangle: Rectangle = { Rectangle() }()
    private lazy var circle: Circle = { Circle() }()
    private lazy var capsule: Capsule = { Capsule(style: .circular) }()
    private lazy var star5: Star = { Star(count: 5, innerRatio: 1) }()
    private lazy var star10: Star = { Star(count: 10, innerRatio: 1) }()
    private lazy var ellipse: Ellipse = { Ellipse() }()
    
    init() {
        switch Int.random(in: 0..<6) {
        case 0: theShape = rectangle
        case 1: theShape = circle
        case 2: theShape = capsule
        case 3: theShape = star5
        case 4: theShape = star10
        default: theShape = ellipse
        }
    }
    
    func path(in rect: CGRect) -> Path {
        theShape!.path(in: rect)
    }
}

// From P229_StarShape
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

struct P273_ShapeGenerator_Previews: PreviewProvider {
    static var previews: some View {
        P273_ShapeGenerator()
    }
}
