//
//  P213_Zoomable.swift
//  
//  Package : https://github.com/jasudev/Zoomable.git
//  Created by jasu on 2022/01/29.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

public struct P213_Zoomable: View {
    
    private let url = URL(string: "https://images.unsplash.com/photo-1641130663904-d6cb4772fad5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1432&q=80")!
    
    @State private var selection: Int = 0
    
    private var content: some View {
        GeometryReader { proxy in
            TabView(selection: $selection) {
                ZoomableView(size: CGSize(width: proxy.size.width, height: proxy.size.width), min: 1.0, max: 6.0, showsIndicators: true) {
                    Image(systemName: "snow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width, height: proxy.size.width)
                        .foregroundColor(Color.fabulaBack1)
                        .background(Color.fabulaFore1)
                        .clipped()
                }
                .frame(width: proxy.size.width, height: proxy.size.width)
                .overlay(
                    Rectangle()
                        .fill(Color.clear)
                        .border(Color.fabulaPrimary, width: 1)
                )
                .tabItem {
                    Image(systemName: "0.square.fill")
                    Text("ZoomableView")
                }
                .tag(0)
                
                ZoomableImageView(url: url, min: 1.0, max: 3.0, showsIndicators: true) {
                    Text("ZoomableImageView")
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                }
                .overlay(
                    Rectangle()
                        .fill(Color.clear)
                        .border(Color.fabulaPrimary, width: 1)
                )
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("ZoomableImageView")
                }
                .tag(1)
            }
        }
    }
    
    public init() {}
    public var body: some View {
#if os(iOS)
        content
            .navigationTitle(Text(selection == 0 ? "ZoomableView" : "ZoomableImageView"))
            .padding()
#else
        ZStack {
            content
                .padding()
        }
        
#endif
    }
}

fileprivate
struct ZoomableView<Content>: View where Content: View {

    private var size: CGSize
    private var min: CGFloat = 1.0
    private var max: CGFloat = 3.0
    private var showsIndicators: Bool = false
    @ViewBuilder private var content: () -> Content

    /**
     Initializes an `ZoomableView`
     - parameter size : The content size of the views.
     - parameter min : The minimum value that can be zoom out.
     - parameter max : The maximum value that can be zoom in.
     - parameter showsIndicators : A value that indicates whether the scroll view displays the scrollable component of the content offset, in a way that’s suitable for the platform.
     - parameter content : The ZoomableView view’s content.
     */
    init(size: CGSize,
                min: CGFloat = 1.0,
                max: CGFloat = 3.0,
                showsIndicators: Bool = false,
                @ViewBuilder content: @escaping () -> Content) {
        self.size = size
        self.min = min
        self.max = max
        self.showsIndicators = showsIndicators
        self.content = content
    }
    
    var body: some View {
        content()
            .frame(width: size.width, height: size.height, alignment: .center)
            .contentShape(Rectangle())
            .modifier(ZoomableModifier(contentSize: self.size, min: min, max: max, showsIndicators: showsIndicators))
    }
}

fileprivate
struct ZoomableImageView<Content>: View where Content: View {
    
    private var url: URL
    private var min: CGFloat = 1.0
    private var max: CGFloat = 3.0
    private var showsIndicators: Bool = false
    @ViewBuilder private var overlay: () -> Content
    
    @State private var imageSize: CGSize = .zero
    
    /**
     Initializes an `ZoomableImageView`
     - parameter url : The image url.
     - parameter min : The minimum value that can be zoom out.
     - parameter max : The maximum value that can be zoom in.
     - parameter showsIndicators : A value that indicates whether the scroll view displays the scrollable component of the content offset, in a way that’s suitable for the platform.
     - parameter overlay : The ZoomableImageView view’s overlay.
     */
    init(url: URL,
                min: CGFloat = 1.0,
                max: CGFloat = 3.0,
                showsIndicators: Bool = false,
                @ViewBuilder overlay: @escaping () -> Content) {
        self.url = url
        self.min = min
        self.max = max
        self.showsIndicators = showsIndicators
        self.overlay = overlay
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZoomableView(size: imageSize, min: self.min, max: self.max, showsIndicators: self.showsIndicators) {
                WebImage(url: url)
                    .resizable()
                    .onSuccess(perform: { image, _, _ in
                        DispatchQueue.main.async {
                            self.imageSize = CGSize(width: proxy.size.width, height: proxy.size.width * (image.size.height / image.size.width))
                        }
                    })
                    .indicator(.activity)
                    .scaledToFit()
                    .clipShape(Rectangle())
                    .overlay(self.overlay())
            }
        }
    }
}

fileprivate
struct ZoomableModifier: ViewModifier {
    
    private enum ZoomState {
        case inactive
        case active(scale: CGFloat)
        
        var scale: CGFloat {
            switch self {
            case .active(let scale):
                return scale
            default: return 1.0
            }
        }
    }
    
    private var contentSize: CGSize
    private var min: CGFloat = 1.0
    private var max: CGFloat = 3.0
    private var showsIndicators: Bool = false
    
    @GestureState private var zoomState = ZoomState.inactive
    @State private var currentScale: CGFloat = 1.0
    
    /**
     Initializes an `ZoomableModifier`
     - parameter contentSize : The content size of the views.
     - parameter min : The minimum value that can be zoom out.
     - parameter max : The maximum value that can be zoom in.
     - parameter showsIndicators : A value that indicates whether the scroll view displays the scrollable component of the content offset, in a way that’s suitable for the platform.
     */
    init(contentSize: CGSize,
                min: CGFloat = 1.0,
                max: CGFloat = 3.0,
                showsIndicators: Bool = false) {
        self.contentSize = contentSize
        self.min = min
        self.max = max
        self.showsIndicators = showsIndicators
    }
    
    var scale: CGFloat {
        return currentScale * zoomState.scale
    }
    
    var zoomGesture: some Gesture {
        MagnificationGesture()
            .updating($zoomState) { value, state, transaction in
                state = .active(scale: value)
            }
            .onEnded { value in
                var new = self.currentScale * value
                if new <= min { new = min }
                if new >= max { new = max }
                self.currentScale = new
            }
    }
    
    var doubleTapGesture: some Gesture {
        TapGesture(count: 2).onEnded {
            if scale <= min { currentScale = max } else
            if scale >= max { currentScale = min } else {
                currentScale = ((max - min) * 0.5 + min) < scale ? max : min
            }
        }
    }
    
    func body(content: Content) -> some View {
        ScrollView([.horizontal, .vertical], showsIndicators: showsIndicators) {
            content
                .frame(width: contentSize.width * scale, height: contentSize.height * scale, alignment: .center)
                .scaleEffect(scale, anchor: .center)
        }
        .gesture(ExclusiveGesture(zoomGesture, doubleTapGesture))
        .animation(.easeInOut, value: scale)
    }
}

struct P213_Zoomable_Previews: PreviewProvider {
    static var previews: some View {
        P213_Zoomable()
    }
}
