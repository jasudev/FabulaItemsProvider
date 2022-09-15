//
//  P264_DynamicFontSize.swift
//
//
//  Created by Lee on 2022/09/15.
//

import SwiftUI

public struct P264_DynamicFontSize: View {
    private let firstBgColor = Color.fabulaPrimary
    private let secondBgColor = Color.fabulaSecondary
    private let text = "The font size is automatically converted to fit the view size. The font size is automatically converted to fit the view size. "
    @State private var lineLimit = ""
    
    public var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Basic")
                dynamicFontViewGroup(bgColor: firstBgColor, text: text, lineLimit: 999)
            }
            VStack {
                Text("Set LineLimit")
                Section {
                    TextField("Enter LineLimit Value", text: $lineLimit)
                        .padding(10)
                        .background(Color.fabulaBack1)
                }.padding(10)
                dynamicFontViewGroup(bgColor: secondBgColor, text: text, lineLimit: Int(lineLimit) ?? 0)
            }
            Spacer()
        }
    }
}

fileprivate struct dynamicFontViewGroup: View {
    var bgColor: Color?
    var text: String
    var lineLimit: Int
    
    var body: some View {
        GeometryReader { geom in
            HStack {
                Spacer()
                ZStack {
                    bgColor
                    Text(text).dynamicFont(lineLimit: lineLimit)
                }.frame(width: geom.size.width / 20, height: geom.size.width / 20)
                ZStack {
                    bgColor
                    Text(text).dynamicFont(lineLimit: lineLimit)
                }.frame(width: geom.size.width / 15, height: geom.size.width / 15)
                ZStack {
                    bgColor
                    Text(text).dynamicFont(lineLimit: lineLimit)
                }.frame(width: geom.size.width / 10, height: geom.size.width / 10)
                ZStack {
                    bgColor
                    Text(text).dynamicFont(lineLimit: lineLimit)
                }.frame(width: geom.size.width / 5, height: geom.size.width / 5)
                ZStack {
                    bgColor
                    Text(text).dynamicFont(lineLimit: lineLimit)
                }.frame(width: geom.size.width / 3, height: geom.size.width / 3)
                Spacer()
            }
        }
    }
}


fileprivate struct dyanmicFontModifier: ViewModifier {
    var lineLimit: Int
    var fontSize: CGFloat?

    func body(content: Content) -> some View {
        Spacer()
        content
            .font(.system(size: fontSize ?? 100))
            .lineLimit(lineLimit)
            .minimumScaleFactor(0.001)
        Spacer()
    }
}

fileprivate extension View {
    func dynamicFont(lineLimit: Int = 0, fontSize: CGFloat? = nil) -> some View {
        return modifier(dyanmicFontModifier(lineLimit: lineLimit))
    }
}


struct P264_DynamicFontSize_Previews: PreviewProvider {
    static var previews: some View {
        P264_DynamicFontSize()
    }
}
