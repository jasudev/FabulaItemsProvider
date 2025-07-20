//
//  P231_AxisContribution.swift
//  
//  Package : https://github.com/jasudev/AxisContribution.git
//  Created by jasu on 2022/02/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisContribution

public struct P231_AxisContribution: View {
   
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var constant: ACConstant = .init(axisMode: .horizontal)
    @State private var rowSize: CGFloat = 11
    @State private var rowImageName: String = ""
    
    public init() {}
    public var body: some View {
        VStack {
            Spacer()

            AxisContribution(constant: constant, source: getDates()) { indexSet, data in
                if rowImageName.isEmpty {
                    defaultBackground
                }else {
                    background
                }
            } foreground: { indexSet, data in
                if rowImageName.isEmpty {
                    defaultForeground
                }else {
                    foreground
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(Color.fabulaFore1.opacity(0.6))
                    .opacity(0.5)
            )
            .frame(maxWidth: 833, maxHeight: 833)
            
            Spacer()
            Picker("", selection: $rowImageName) {
                Text("Default").tag("")
                Image(systemName: "heart.fill").tag("heart.fill")
                Image(systemName: "umbrella.fill").tag("umbrella.fill")
                Image(systemName: "flame.fill").tag("flame.fill")
                Image(systemName: "seal.fill").tag("seal.fill")
            }
            .pickerStyle(.segmented)
            HStack {
                Text("Row Size : ")
                Slider(value: $rowSize, in: 11...40)
                Text("\(rowSize, specifier: "%.2f")")
            }
            Picker("", selection: $constant.axisMode) {
                Text("Horizontal").tag(ACAxisMode.horizontal)
                Text("Vertical").tag(ACAxisMode.vertical)
            }
            .pickerStyle(.segmented)
        }
        .padding()
    }
    
    private var defaultBackground: some View {
        Rectangle()
            .fill(Color.fabulaBack2.opacity(0.8))
            .frame(width: rowSize, height: rowSize)
            .cornerRadius(2)
    }
    
    private var defaultForeground: some View {
        Rectangle()
            .fill(Color(hex: 0x6CD164))
            .frame(width: rowSize, height: rowSize)
            .border(Color.white.opacity(0.2), width: 1)
            .cornerRadius(2)
    }
    
    private var background: some View {
        Image(systemName: rowImageName)
            .foregroundColor(Color.fabulaBack2.opacity(0.8))
            .font(.system(size: rowSize))
            .frame(width: rowSize, height: rowSize)
    }
    
    private var foreground: some View {
        Image(systemName: rowImageName)
            .foregroundColor(Color(hex: 0x6CD164))
            .font(.system(size: rowSize))
            .frame(width: rowSize, height: rowSize)
    }
    
    private func getDates() -> [Date: ACData] {
        var sequenceDatas = [Date: ACData]()
        for _ in 0..<300 {
            let date = Date.randomBetween(start: Date().dateHalfAyear, end: Date())
            let data = ACData(date: date, count: Int.random(in: 0...4))
            sequenceDatas[date] = data
        }
        return sequenceDatas
    }
}

fileprivate
extension Date {
    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }

    var dateHalfAyear: Date {
        var components = DateComponents()
        components.month = -6
        guard let date = Calendar.current.date(byAdding: components, to: startOfDay) else { return Date() }
        return date
    }

    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}

struct P231_AxisContribution_Previews: PreviewProvider {
    static var previews: some View {
        P231_AxisContribution()
    }
}
