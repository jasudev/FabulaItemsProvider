//
//  P48_Joystick.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P48_Joystick: View {
    
    @State private var stickPosition: CGPoint = .zero
    
    public init() {}
    public var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("X : \(Int(stickPosition.x))")
                Text("Y : \(Int(stickPosition.y))")
            }
            .animation(.easeInOut, value: stickPosition)
            
            JoyStickView{ (state, stickPosition) in
                self.stickPosition = stickPosition
            }
        }
    }
}

fileprivate
extension CGPoint {
    
    func getPointOnCircle(radius: CGFloat, radian: CGFloat) -> CGPoint {
        let x = self.x + radius * cos(radian)
        let y = self.y + radius * sin(radian)
        
        return CGPoint(x: x, y: y)
    }
    
    func getRadian(pointOnCircle: CGPoint) -> CGFloat {
        
        let originX = pointOnCircle.x - self.x
        let originY = pointOnCircle.y - self.y
        var radian = atan2(originY, originX)
        
        while radian < 0 {
            radian += CGFloat(2 * Double.pi)
        }
        
        return radian
    }
    
    func getDistance(otherPoint: CGPoint) -> CGFloat {
        return sqrt(pow((otherPoint.x - x), 2) + pow((otherPoint.y - y), 2))
    }
}

fileprivate
struct Stick: View {
    
    @Environment(\.colorScheme) private var colorScheme
    var diameter: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 1)
                .frame(width: 8, height: 8)
                .foregroundColor(Color.fabulaPrimary)
        }
        .frame(width: diameter, height: diameter)
        .background(colorScheme == .light ? LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.8705882353, green: 0.8941176471, blue: 0.9450980392, alpha: 1))]), startPoint: .top, endPoint: .bottom) : LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1883467436, green: 0.1946772635, blue: 0.2135235071, alpha: 1)), Color(#colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1254901961, alpha: 1))]), startPoint: .topLeading, endPoint: .bottom))
        .clipShape(Circle())
        .shadow(color: colorScheme == .dark ? Color.black.opacity(0.5) : Color.black.opacity(0.2), radius: 16, x: 0, y: 16)
    }
}

fileprivate
struct CircleBoundary: View {
    
    @Environment(\.colorScheme) private var colorScheme
    var diameter: CGFloat
    let lineWidth: CGFloat = 5
    
    var body: some View {
        Circle()
            .fill(Color.black.opacity(0.001))
            .frame(width: diameter, height: diameter)
            .background(
                ZStack {
                    Circle()
                        .strokeBorder(lineWidth: diameter / 2)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        .frame(width: diameter + diameter, height: diameter + diameter)
                        .shadow(color: colorScheme == .dark ? Color.black.opacity(0.5) : Color.black.opacity(0.1), radius: diameter * 0.05, x: 10, y: diameter * 0.05)
                }
            )
            .mask(Circle())
    }
}

fileprivate
extension CGFloat {
    func text() -> String {
        return String(format: "%.00f", Float(self))
    }
}

fileprivate
enum JoyStickState: String {
    case up
    case down
    case left
    case right
    case center
}

fileprivate
struct JoyStickView: View {
    
    var stickPosition: CGPoint {
        let x = floor(locationX - boundaryRadius)
        let y = floor((locationY - boundaryRadius) < 0 ? (locationY - boundaryRadius) : locationY - boundaryRadius)
        return CGPoint(x: x, y: y)
    }
    
    @State private var joyStickState: JoyStickState = .center
    @State private var isShowAnimation: Bool = false
    
    public var completionHandler: ((_ joyStickState: JoyStickState, _ stickPosition: CGPoint) -> Void)
    
    var org: CGPoint {
        return CGPoint(x: self.boundaryRadius, y: self.boundaryRadius)
    }
    
    @State var locationX: CGFloat = 0
    @State var locationY: CGFloat = 0
    
    let iconPadding: CGFloat = 10
    
    var stickDiameter: CGFloat {
        return stickRadius * 2
    }
    
    var boundaryDiameter: CGFloat {
        return boundaryRadius * 2
    }
    
    var stickRadius: CGFloat
    var boundaryRadius: CGFloat
    
    var smallRingLocationX: CGFloat {
        return locationX - boundaryRadius
    }
    
    var smallRingLocationY: CGFloat {
        return locationY - boundaryRadius
    }
    
    func getJoyStickState() -> JoyStickState {
        var state: JoyStickState = .center
        
        let xValue = locationX - boundaryRadius
        let yValue = locationY - boundaryRadius
        
        if (abs(xValue) > abs(yValue)) {
            state = xValue < 0 ? .left : .right
        } else if (abs(yValue) > abs(xValue)) {
            state = yValue < 0 ? .up : .down
        }
        
        return state
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged{ value in
                let distance = self.org.getDistance(otherPoint: value.location)
                
                let stickLimitCenter: CGFloat = self.boundaryRadius - self.stickRadius
                
                if (distance <= stickLimitCenter) {
                    self.locationX = value.location.x
                    self.locationY = value.location.y
                } else {
                    let radian = self.org.getRadian(pointOnCircle: value.location)
                    let pointOnCircle = self.org.getPointOnCircle(radius: stickLimitCenter, radian: radian)
                    
                    self.locationX = pointOnCircle.x
                    self.locationY = pointOnCircle.y
                }
                
                self.joyStickState = self.getJoyStickState()
                
                self.completionHandler(self.joyStickState,  self.stickPosition)
            }
            .onEnded{ value in
                
                self.locationX = self.boundaryRadius
                self.locationY = self.boundaryRadius
                
                self.joyStickState = .center
                
                self.completionHandler(self.joyStickState,  self.stickPosition)
            }
    }
    
    
    init(stickRadius: CGFloat = 70, boundaryRadius: CGFloat = 160,
         completionHandler: @escaping ((_ joyStickState: JoyStickState, _ stickPosition: CGPoint) -> Void)) {
        
        self.stickRadius = stickRadius
        self.boundaryRadius = boundaryRadius
        
        self.completionHandler = completionHandler
    }
    
    var body: some View {
        ZStack {
            CircleBoundary(diameter: boundaryDiameter)
                .gesture(dragGesture)
            
            Stick(diameter: self.stickDiameter)
                .background(
                    Circle()
                        .fill(Color.fabulaBack1)
                        .scaleEffect(0.99)
                        .shadow(color: Color.fabulaPrimary.opacity(0.8).opacity((abs(self.stickPosition.x) + abs(self.stickPosition.y)) * 0.01),
                                radius: (self.locationX + self.locationY) * 0.03, x: (self.locationX - self.boundaryRadius) * -0.16, y: (self.locationY - self.boundaryRadius) * -0.16)
                )
                .offset(x: smallRingLocationX, y: smallRingLocationY)
                .allowsHitTesting(false)
            
                .animation(!isShowAnimation ? .none : .spring(response: 0.25, dampingFraction: 0.7, blendDuration: 0.7), value: locationX)
        }
        .onAppear(){
            self.locationX = self.boundaryRadius
            self.locationY = self.boundaryRadius
            
            DispatchQueue.main.async {
                isShowAnimation = true
            }
        }
        .padding(40)
    }
}

struct P48_Joystick_Previews: PreviewProvider {
    static var previews: some View {
        P48_Joystick()
            .background(Color.fabulaBack1)
            .preferredColorScheme(.dark)
    }
}
