//
//  P173_RectangularGraph.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P173_RectangularGraph: View {
    
    @StateObject private var viewModel = RectangularViewModel()
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            let size = CGSize(width: (proxy.size.width / 1.5) / CGFloat(viewModel.datas.count), height: proxy.size.height / 1.5)
            ZStack {
                Color.clear
                RectangularGraph(eachSize: size, datas: $viewModel.datas)
            }
        }
        .padding()
    }
}

fileprivate
class RectangularGraphData: ObservableObject, Identifiable {
    var id = UUID()
    @Published var progress: CGFloat
    let color: Color
    
    init(progress: CGFloat, color: Color) {
        self.progress = progress
        self.color = color
    }
}

fileprivate
class RectangularViewModel: ObservableObject {
    @Published var datas = [RectangularGraphData]()
    let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C)]
    init() {
        var items = [RectangularGraphData]()
        for i in 0..<colors.count {
            items.append(RectangularGraphData(progress: CGFloat(i + 1) * 0.1, color: colors[i]))
        }
        datas = items
    }
}

fileprivate
struct RectangularGraph: View {
    
    var eachSize: CGSize
    @Binding var datas: [RectangularGraphData]
    @GestureState private var translation: CGFloat = 0
    
    var body: some View {
        HStack(alignment: .bottom, spacing: -eachSize.width / 7) {
            ForEach(Array(datas.enumerated()), id:\.offset) { index, data in
                RectangularView(size: eachSize, progress: data.progress)
                    .zIndex(CGFloat(8 - index) * 0.1)
                    .offset(y: eachSize.width / 3.5 * -CGFloat(index))
                    .foregroundColor(data.progress == 0 ? Color(hex: 0x363636) : data.color)
                    .gesture(
                        DragGesture().updating(self.$translation) { value, state, _ in
                            state = value.translation.height
                        }
                            .onChanged{ value in
                                data.progress += (value.translation.height * -0.0001)
                                data.progress = min(data.progress, 1)
                                data.progress = max(data.progress, 0)
                            }
                    )
            }
        }
        .animation(.easeInOut, value: translation)
    }
}

fileprivate
struct RectangularView: View {
    
    let size: CGSize
    let progress: CGFloat
    
    var body: some View {
        ZStack {
            RectangularTopShape().brightness(0)
            RectangularLeftShape().brightness(-0.05)
            RectangularRightShape().brightness(0.1)
        }
        .overlay(
            VStack {
                Spacer()
                Text("\(Int(progress * 100.0))")
                    .font(.system(size: size.width / 4))
                    .bold()
                    .offset(x: size.width / 6, y: size.width / 2)
                    .rotationEffect(.degrees(-40))
                    .scaleEffect(CGSize(width: 1, height: 0.6))
            }
        )
        .frame(width: size.width, height: size.width + (size.height - size.width) * progress)
    }
    
    struct RectangularLeftShape: Shape {
        func path(in rect: CGRect) -> Path {
            
            var path = Path()
            let startPoint = CGPoint(x: 0, y: rect.width / 4)
            
            path.move(to: startPoint)
            path.addLine(to: CGPoint(x: rect.width / 2.1, y: (rect.width / 2.1)))
            path.addLine(to: CGPoint(x: rect.width / 2.1, y : rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height - (rect.width / 4)))
            path.addLine(to: startPoint)
            path.closeSubpath()
            return path
        }
    }
    
    struct RectangularRightShape: Shape {
        func path(in rect: CGRect) -> Path {
            
            var path = Path()
            let startPoint = CGPoint(x: rect.width / 2.1, y: (rect.width / 2.1))
            
            path.move(to: startPoint)
            path.addLine(to: CGPoint(x: rect.width, y: rect.width / 4))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height - (rect.width / 4)))
            path.addLine(to: CGPoint(x: rect.width / 2.1, y: rect.height))
            path.addLine(to: startPoint)
            path.closeSubpath()
            return path
        }
    }
    
    struct RectangularTopShape: Shape {
        func path(in rect: CGRect) -> Path {
            
            var path = Path()
            let startPoint = CGPoint(x: 0, y: rect.width / 4)
            
            path.move(to: startPoint)
            path.addLine(to: CGPoint(x: rect.width - (rect.width / 2.1), y: (rect.width / 25)))
            path.addLine(to: CGPoint(x: rect.width, y: (rect.width / 4)))
            path.addLine(to: CGPoint(x: rect.width / 2.1, y: (rect.width / 2.1)))
            path.addLine(to: startPoint)
            path.closeSubpath()
            return path
        }
    }
}

struct P173_RectangularGraph_Previews: PreviewProvider {
    static var previews: some View {
        P173_RectangularGraph()
    }
}
