//
//  P277_DragAndResize.swift
//  
//
//  Created by tgeisse on 12/5/22.
//

import SwiftUI

public struct P277_DragAndResize: View {
    public init() { }
    
    public var body: some View {
        DragAndResize()
    }
}

fileprivate struct DragAndResize: View {
    var body: some View {
        DraggableAndResizableView {
            Image(systemName: "atom")
                .resizable()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .mint)
        }
    }
}

fileprivate struct ResizePoint: Identifiable {
    let id = UUID()
    let x: RelativeLocation
    let y: RelativeLocation
    
    enum RelativeLocation {
        case zero
        case middle
        case max
        
        func value(from: CGFloat) -> CGFloat {
            switch self {
            case .zero: return 0
            case .middle: return from / 2
            case .max: return from
            }
        }
    }
}

fileprivate struct DraggableAndResizableView<Content: View>: View {
    @ViewBuilder let content: () -> Content
    
    private let initialSize: CGSize
    @State private var size: CGSize
    @State private var offset: CGPoint = .zero
    private let resizablePoints: [ResizePoint] = [ // position is relative to their place around the view
        ResizePoint(x: .zero, y: .zero), ResizePoint(x: .middle, y: .zero), ResizePoint(x: .max, y: .zero),
        ResizePoint(x: .zero, y: .middle),  ResizePoint(x: .max, y: .middle),
        ResizePoint(x: .zero, y: .max), ResizePoint(x: .middle, y: .max), ResizePoint(x: .max, y: .max),
    ]
    
    init(initialSize: CGSize = CGSize(width: 200, height: 200),
         content: @escaping () -> Content) {
        
        self.content = content
        self.initialSize = initialSize
        self.size = initialSize
    }
    
    var body: some View {
        GeometryReader { screen in
            ZStack {
                content()
                    .padding(8)
                    .frame(width: size.width, height: size.height)
                    .offset(x: offset.x,
                            y: offset.y)
                    .gesture(ViewDragGesture(point: $offset))
                
                ForEach(resizablePoints) { resizePoint in
                    let pointLocation = CGPoint(x: offset.x - size.width / 2
                                                + resizePoint.x.value(from: size.width),
                                                
                                                y: offset.y - size.height / 2
                                                + resizePoint.y.value(from: size.height))
                    
                    Rectangle()
                        .stroke(.primary)
                        .background(Rectangle().fill(.gray))
                        .frame(width: 6, height: 6)
                        .offset(x: pointLocation.x,
                                y: pointLocation.y)
                        .gesture(ResizePointDragGesture(resizePoint: resizePoint,
                                                        offset: $offset,
                                                        size: $size)
                                 )
                }
            }
            .onAppear {
                reset(screenSize: screen.size)
            }
            .onTapGesture(count: 2) {
                reset(screenSize: screen.size)
            }
        }
        .ignoresSafeArea()
    }
    
    private func reset(screenSize : CGSize) {
        size = initialSize
        offset.x = screenSize.width / 2 - size.width / 2
        offset.y = screenSize.height / 2 - size.height / 2
        
    }
}

fileprivate struct ViewDragGesture: Gesture {
    @Binding var point: CGPoint
    @State private var startingPoint: CGPoint? = nil
    
    var body: some Gesture {
        DragGesture()
            .onChanged { value in
                if startingPoint == nil {
                    startingPoint = point
                }
                
                point.x = startingPoint!.x + value.translation.width
                point.y = startingPoint!.y + value.translation.height
            }
            .onEnded { _ in
                startingPoint = nil
            }
    }
}

fileprivate struct ResizePointDragGesture: Gesture {
    let resizePoint: ResizePoint
    @Binding var offset: CGPoint
    @Binding var size: CGSize
    
    @State private var startingSize: CGSize? = nil
    @State private var startingOffset: CGPoint? = nil
    
    var body: some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged { value in
                if startingSize == nil {
                    startingSize = size
                }
                
                if startingOffset == nil {
                    startingOffset = offset
                }
                
                switch resizePoint.x {
                case .zero: size.width = startingSize!.width - value.translation.width
                case .max: size.width = startingSize!.width + value.translation.width
                default: break
                }
                
                let widthMin: CGFloat = 10
                let widthMinReached = size.width <= widthMin
                size.width = max(widthMin, size.width)
                
                switch resizePoint.y {
                case .zero: size.height = startingSize!.height - value.translation.height
                case .max: size.height = startingSize!.height + value.translation.height
                default: break
                }
                
                let heightMin: CGFloat = 10
                let heightMinReached = size.height <= heightMin
                size.height = max(heightMin, size.height)
                
                if !widthMinReached && resizePoint.x == .zero {
                    offset.x = startingOffset!.x + value.translation.width
                }
                
                if !heightMinReached && resizePoint.y == .zero {
                    offset.y = startingOffset!.y + value.translation.height
                }
            }
            .onEnded { _ in
                startingSize = nil
                startingOffset = nil
            }
    }
}

struct P277_DragAndResize_Previews: PreviewProvider {
    static var previews: some View {
        P277_DragAndResize()
    }
}
