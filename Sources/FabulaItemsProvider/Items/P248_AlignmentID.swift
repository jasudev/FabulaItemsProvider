//
//  P248_AlignmentID.swift
//  
//
//  Created by jasu on 2022/05/14.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P248_AlignmentID: View {
    public init() {}
    public var body: some View {
        VStack {
            VerticalView()
            HorizontalView()
        }
    }
}

fileprivate
struct VerticalView: View {
    
    @State private var currentIndex = 1
    
    var body: some View {
        HStack(alignment: .verticalAlignment, spacing: 5) {
            Rectangle().frame(width: 5, height: 15).foregroundColor(Color.fabulaPrimary)
                .alignmentGuide(.verticalAlignment, computeValue: { d in
                    d[VerticalAlignment.center] })
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<6, id: \.self) { index in
                    Group {
                        if index == self.currentIndex {
                            Text("Menu \(index)")
                                .alignmentGuide(.verticalAlignment, computeValue: { d in
                                    d[VerticalAlignment.center] })
                        } else {
                            Text("Menu \(index)")
                                .onTapGesture {
                                    withAnimation {
                                        self.currentIndex = index
                                    }
                                }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

fileprivate
struct HorizontalView: View {
    
    @State private var currentIndex = 1
    
    var body: some View {
        VStack(alignment: .horizontalAlignment, spacing: 5) {
            HStack(alignment: .top, spacing: 15) {
                ForEach(0..<4, id: \.self) { index in
                    Group {
                        if index == self.currentIndex {
                            Text("Menu \(index)")
                                .alignmentGuide(.horizontalAlignment, computeValue: { d in
                                    d[HorizontalAlignment.center] })
                        } else {
                            Text("Menu \(index)")
                                .onTapGesture {
                                    withAnimation {
                                        self.currentIndex = index
                                    }
                                }
                        }
                    }
                }
            }
            Rectangle().frame(width: 55, height: 5).foregroundColor(Color.fabulaPrimary)
                .alignmentGuide(.horizontalAlignment, computeValue: { d in
                    d[HorizontalAlignment.center] })
        }
        .padding()
    }
}

fileprivate
extension VerticalAlignment {
    private enum CurrentAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[VerticalAlignment.center]
        }
    }
    static let verticalAlignment = VerticalAlignment(CurrentAlignment.self)
}

fileprivate
extension HorizontalAlignment {
    private enum CurrentAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[HorizontalAlignment.center]
        }
    }
    static let horizontalAlignment = HorizontalAlignment(CurrentAlignment.self)
}

struct P248_AlignmentID_Previews: PreviewProvider {
    static var previews: some View {
        P248_AlignmentID()
    }
}
