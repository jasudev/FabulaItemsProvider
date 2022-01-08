//
//  P14_Umbrella.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI
import SpriteKit
import CoreMotion

public struct P14_Umbrella: View {
    
    @State private var isOpen: Bool = false
    @State private var isActive: Bool = false
    private let gXs: [CGFloat] = [-2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2]
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                if !isActive {
                    SpriteView(scene: getOutsideScene(proxy.size))
                    SpriteView(scene: getInsideScene(proxy.size))
                        .rotationEffect(Angle(degrees: 180))
                        .mask(
                            Image(systemName: "umbrella")
                                .font(.system(size: proxy.minSize / 1.5))
                        )
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func getInsideScene(_ size: CGSize) -> SKScene {
        let scene = InsideScene()
        scene.size = size
        scene.scaleMode = .fill
        scene.backgroundColor = SKColor(named: "colorBack1") ?? SKColor.black
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        return scene
    }
    
    private func getOutsideScene(_ size: CGSize) -> SKScene {
        let scene = OutsideScene()
        scene.size = size
        scene.scaleMode = .fill
        scene.backgroundColor = SKColor(named: "colorBack1") ?? SKColor.black
        scene.physicsWorld.gravity = CGVector(dx: gXs.randomElement() ?? 0, dy: -5)
        return scene
    }
}

fileprivate
class CircleNode: SKShapeNode {
    
    private var screenSize: CGSize!
    private var circleSize: CGFloat = 20
    private var isOutside: Bool = false
    
    override init() {
        super.init()
    }
    
    convenience init(screenSize: CGSize, circleSize: CGFloat, isOutside: Bool) {
        self.init()
        self.init(circleOfRadius: circleSize)
        self.screenSize = screenSize
        self.circleSize = circleSize
        self.isOutside = isOutside
        
        if !isOutside {
            self.fillColor = Bool.random() ? SKColor(named: "colorPrimary") ?? SKColor.red : SKColor(named: "colorSecondary") ?? SKColor.blue
        }else {
            self.fillColor = Bool.random() ? SKColor(named: "colorFore1") ?? SKColor.gray : SKColor(named: "colorFore2") ?? SKColor.darkGray
        }
        
        self.strokeColor = SKColor.clear
        self.physicsBody = SKPhysicsBody(circleOfRadius: circleSize * 1.1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkRemoveNode() -> Bool {
        let dim: CGFloat = circleSize
        if self.position.y < -self.screenSize.height || self.position.x < -dim || self.position.x > (self.screenSize.width + dim) {
            
            return true
        }
        return false
    }
}

fileprivate
class InsideScene: SKScene {
    
    var timer: Timer?
    
    override func didMove(to view: SKView) {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.createNode), userInfo: nil, repeats: true)
    }
    
    @objc func createNode() {
        let hWidth = self.size.width / 2
        let fontSize = (self.size.width < self.size.height ? self.size.width / 1.5 : self.size.height / 1.5) / 2
        let location = CGPoint(x: hWidth + CGFloat.random(in: -fontSize..<fontSize), y: self.size.height + 50)
        createBox(location)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in self.children {
            node.xScale += 0.01
            node.yScale += 0.01
            let dim: CGFloat = 30 * node.yScale
            if node.position.y < -self.size.height || node.position.x < -dim || node.position.x > (self.size.width + dim) {
                node.removeFromParent()
            }
        }
    }
    
    func createBox(_ location: CGPoint) {
        let box = CircleNode(screenSize: self.size, circleSize: 16, isOutside: false)
        box.position = location
        addChild(box)
    }
    
    deinit {
        self.timer?.invalidate()
    }
}

fileprivate
class OutsideScene: SKScene {
    
    var timer: Timer?
    var largeCircleNode: SKShapeNode!
    var smallCircleNode: SKShapeNode!
    var smallBoxNode: SKShapeNode!
    
#if os(iOS)
    private var manager: CMMotionManager!
#endif
    override func didMove(to view: SKView) {
        
#if os(iOS)
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 0.1
        self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard error == nil else {
                print(error!)
                return
            }
            
            if let motionData = motionData {
                self.physicsWorld.gravity = CGVector(dx: motionData.attitude.roll * 4, dy: -6)
            }
        }
#endif
        
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.createNode), userInfo: nil, repeats: true)
        
        let largeDiv: CGFloat = 3.0
        let largeSize = self.size.width < self.size.height ? self.size.width / largeDiv : self.size.height / largeDiv
        largeCircleNode = SKShapeNode(circleOfRadius: largeSize)
        largeCircleNode.fillColor = SKColor.blue
        largeCircleNode.strokeColor = SKColor.clear
        largeCircleNode.physicsBody = SKPhysicsBody(circleOfRadius: largeSize)
        largeCircleNode.physicsBody?.isDynamic = false
        largeCircleNode.isHidden = true
        largeCircleNode.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - largeSize * 0.05)
        addChild(largeCircleNode)
        
        
        let smallSize = largeSize / 12
        smallCircleNode = SKShapeNode(circleOfRadius: smallSize)
        smallCircleNode.fillColor = SKColor.red
        smallCircleNode.strokeColor = SKColor.clear
        smallCircleNode.physicsBody = SKPhysicsBody(circleOfRadius: smallSize)
        smallCircleNode.physicsBody?.isDynamic = false
        smallCircleNode.isHidden = true
        smallCircleNode.position = CGPoint(x: largeCircleNode.position.x, y: largeCircleNode.position.y + largeSize * 1.14)
        addChild(smallCircleNode)
        
        
        let rect = CGRect(x: smallCircleNode.position.x - smallSize, y: smallCircleNode.position.y - smallSize * 4, width: smallSize * 2, height: smallSize * 4)
        smallBoxNode = SKShapeNode(rect: rect)
        smallBoxNode.fillColor = SKColor.red
        smallBoxNode.strokeColor = SKColor.clear
        smallBoxNode.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        smallBoxNode.physicsBody?.isDynamic = false
        smallBoxNode.isHidden = true
        addChild(smallBoxNode)
    }
    
    @objc func createNode() {
        let hWidth = self.size.width / 2
        let location = CGPoint(x: hWidth + CGFloat.random(in: -hWidth..<hWidth), y: self.size.height + 50)
        createBox(location)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in self.children {
            if largeCircleNode != node && smallCircleNode != node && smallBoxNode != node {
                node.xScale += 0.01
                node.yScale += 0.01
            }
            let dim: CGFloat = 30 * node.yScale
            if node.position.y < -self.size.height || node.position.x < -dim || node.position.x > (self.size.width + dim) {
                node.removeFromParent()
            }
        }
    }
    
#if os(iOS)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        self.physicsWorld.gravity = CGVector(dx: (location.x - self.size.width / 2), dy: -6)
    }
    
#else
    override func mouseDragged(with event: NSEvent) {
        let location = event.location(in: self)
        self.physicsWorld.gravity = CGVector(dx: (location.x - self.size.width / 2), dy: -6)
        print("drag : ", location)
    }
#endif
    
    func createBox(_ location: CGPoint) {
        let box = CircleNode(screenSize: self.size, circleSize: 5, isOutside: true)
        box.position = location
        addChild(box)
    }
    
    deinit {
        self.timer?.invalidate()
    }
}

struct P14_Umbrella_Previews: PreviewProvider {
    static var previews: some View {
        P14_Umbrella()
    }
}
