//
//  P270_HueColorPicker.swift
//
//
//  Created by tgeisse on 11/28/22.
//

import SwiftUI

public struct P270_HueColorPicker: View {
    
    public init() {}
    public var body: some View {
        HueColorPicker()
    }
}

fileprivate struct HueColorPicker: View {
    @State private var hue: Double = 0.5
    @State private var saturation: Double = 1.0
    @State private var brightness: Double = 1.0
    @State private var opacity: Double = 1.0
    
    #if os(iOS)
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    #endif
    
    private var hueColor: Color {
        Color(hue: hue, saturation: saturation, brightness: brightness, opacity: opacity)
    }
    
    // MARK: - LinearGradient for slider controls
    private var hueGradient: LinearGradient = {
        var colors: [Color] = []
        
        for hue in stride(from: 0.0, through: 1.0, by: 0.001) {
            colors.append(Color(hue: hue, saturation: 1, brightness: 1))
        }
        
        return LinearGradient(colors: colors,
                              startPoint: .leading,
                              endPoint: .trailing)
    }()
    
    private var saturationGradient: LinearGradient {
        LinearGradient(colors: [
            Color(hue: hue, saturation: 0, brightness: brightness, opacity: opacity),
            Color(hue: hue, saturation: 1, brightness: brightness, opacity: opacity)
        ], startPoint: .leading, endPoint: .trailing)
    }
    
    private var brightnessGradient: LinearGradient {
        LinearGradient(colors: [
            Color(hue: hue, saturation: saturation, brightness: 0, opacity: opacity),
            Color(hue: hue, saturation: saturation, brightness: 1, opacity: opacity)
        ], startPoint: .leading, endPoint: .trailing)
    }
    
    private var opacityGradient: LinearGradient {
        LinearGradient(colors: [
            Color(hue: hue, saturation: saturation, brightness: brightness, opacity: 0),
            Color(hue: hue, saturation: saturation, brightness: brightness, opacity: 1)
        ], startPoint: .leading, endPoint: .trailing)
    }
    
    // MARK: - Slider Controls into two groups - used on iOS
    private var controlsGroupOne: some View {
        Group {
            SliderStack(label: "Hue", element: $hue, sliderFill: hueGradient)
            SliderStack(label: "Saturation", element: $saturation, sliderFill: saturationGradient)
        }
    }
    
    private var controlsGroupTwo: some View {
        Group {
            SliderStack(label: "Brightness", element: $brightness, sliderFill: brightnessGradient)
            SliderStack(label: "Opacity", element: $opacity, sliderFill: opacityGradient)
        }
    }
    
    // MARK: - Main View body
    var body: some View {
        VStack(spacing: 40) {
            VStack(alignment: .center, spacing: 10) {
                FilledBorderedRectangle(linewidth: 2, fillColor: hueColor)
                    .frame(width: 100, height: 100)
                
                Text("Color(hue: \(hue), saturation: \(saturation), brightness: \(brightness), opacity: \(opacity)")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12))
                    .textSelection(.enabled)
            }
            .frame(width: 300)
            
            #if os(iOS)
            if verticalSizeClass == .compact {
                HStack(spacing: 10) {
                    VStack(spacing: 20) { controlsGroupOne }
                        .frame(width: 300)
                    
                    VStack(spacing: 20) { controlsGroupTwo }
                        .frame(width: 300)
                }
            } else {
                VStack(spacing: 20) {
                    controlsGroupOne
                    controlsGroupTwo
                }
                .frame(width: 300)
            }
            #else
            VStack(spacing: 20) {
                controlsGroupOne
                controlsGroupTwo
            }
            .frame(width: 300)
            #endif
        }
    }
}

fileprivate struct SliderStack: View {
    let label: String
    @Binding var element: Double
    let sliderFill: LinearGradient
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack {
                Spacer()
                    .frame(width: 10)
                
                Text(label)
                    .font(.system(size: 14))
            }
            
            ColorSlider(element: $element, sliderFill: sliderFill)
        }
    }
}

fileprivate struct ColorSlider: View {
    @Binding var element: Double
    let sliderFill: LinearGradient
    
    var body: some View {
        CustomSlider(value: $element, range: 0...1, capsuleFill: sliderFill)
            .frame(height: 30)
    }
}

fileprivate struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let capsuleFill: LinearGradient
    
    @State private var dragStartValue: Double? = nil
    private var rangeMiddle: Double {
        ((range.upperBound - range.lowerBound) / 2) + range.lowerBound
    }
    
    var body: some View {
        GeometryReader { geometry in
            let sliderWidth = geometry.size.width * 0.9
            
            ZStack {
                Capsule()
                    .stroke(Color.fabulaFore2, lineWidth: 1)
                    .background(Capsule()
                        .fill(capsuleFill)
                    )
                
                ZStack {
                    Circle()
                        .stroke(Color.fabulaFore2, lineWidth: 1)
                        .background(Circle()
                            .fill(.white)
                        )
                        
                    Text("\(Int(value * 100))")
                        .font(.system(size: 10))
                        .foregroundColor(.black)
                        .minimumScaleFactor(0.5)
                    
                }
                .frame(height: geometry.size.height * 0.85)
                .offset(x: sliderWidth * (value - rangeMiddle))
                .gesture(DragGesture()
                    .onChanged {
                        if dragStartValue == nil {
                            dragStartValue = value
                        }
                        
                        let changeInRange = ($0.translation.width / sliderWidth) * range.upperBound + range.lowerBound
                        
                        value = max(range.lowerBound, min(range.upperBound, dragStartValue! + changeInRange))
                    }
                    .onEnded { _ in
                        dragStartValue = nil
                    }
                )
            }
        }
    }
}

fileprivate struct FilledBorderedRectangle: View {
    let borderColor: Color = .fabulaFore2
    let linewidth: CGFloat
    let cornerRadius: CGFloat = 13.0
    let fillColor: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(borderColor, lineWidth: linewidth)
            .background(RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(fillColor))
    }
}

struct P270_HueColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        P270_HueColorPicker()
    }
}
