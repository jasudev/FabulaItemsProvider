//
//  SwiftUIView.swift
//
//
//  Created by Lee on 2022/07/15.
//

import SwiftUI

public struct P262_BarGraph: View {
    @State var progress: CGFloat = 50   //init Value
    @State var height: CGFloat = 10     //init Value
    
    public init() {}
    public var body: some View {
        VStack {
            CustomSliderView(type: .height, sliderColor: .fabulaPrimary, value: $height)
                .padding(.bottom, 20)
            CustomSliderView(type: .progress, sliderColor: .fabulaSecondary, value: $progress)
                .padding(.bottom, 40)
            
            BarGraph(height: height, progress: $progress, barColor: .fabulaSecondary)
        }
        .padding(.horizontal, 30)
    }
}

fileprivate struct CustomSliderView: View {
    enum SliderType {
        case height
        case progress
        
        var title: String {
            switch self {
                case .height: return "Height"
                case .progress: return "Progress"
            }
        }
    }

    var type: SliderType
    var sliderColor: Color
    @Binding var value: CGFloat
    
    var body: some View {
        VStack{
            Text(type.title).font(.headline)
            CustomSlider().accentColor(sliderColor)
            Text("\(String(format: "%.1f", value))").font(.subheadline)
        }
        .foregroundColor(sliderColor)
    }
    
    
    fileprivate func CustomSlider() -> Slider<Text, Text> {
        
        return Slider(value: $value,
                      in: 0...100,
                      minimumValueLabel: Text("0"),
                      maximumValueLabel: Text("100"),
                      label: {Text(type.title)})
        
    }
}

fileprivate struct BarGraph: View {
    var height: CGFloat
    @Binding var progress: CGFloat
    var barColor: Color
    private let bgColor = Color.gray
    
    var body: some View {
        GeometryReader { geom in
            ZStack(alignment: .leading) {
                bgColor
                    .gesture(
                    DragGesture()
                        .onChanged{ value in
                            let dragedProgress = value.location.x / geom.size.width * 100
                            if (dragedProgress < 0) {
                                progress = 0
                            } else if (dragedProgress > 100) {
                                progress = 100
                            } else {
                                progress = dragedProgress
                            }
                        }
                )
                barColor.frame(width: geom.size.width * progress / 100)
                    .allowsHitTesting(false)
            }
        }
        .frame(height: height)
        .cornerRadius(height)
    }
}


struct P262_BarGraph_Previews: PreviewProvider {
    static var previews: some View {
        P262_BarGraph()
    }
}
