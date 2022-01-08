//
//  P52_DatePicker.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P52_DatePicker: View {
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let start = DateComponents(year: 2021, month: 1, day: 1)
        let end = DateComponents(year: 2021, month: 12, day: 31)
        return calendar.date(from:start)!...calendar.date(from:end)!
    }()
    
    @State var date: Date = Date()
    
    var datePickerGroup: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                titleView("DefaultDatePickerStyle()")
                datePicker()
                    .datePickerStyle(DefaultDatePickerStyle())
            }
            Divider()
            VStack(alignment: .leading) {
                titleView("GraphicalDatePickerStyle()")
                datePicker()
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
            Divider()
            VStack(alignment: .leading) {
                titleView("CompactDatePickerStyle()")
                datePicker()
                    .datePickerStyle(CompactDatePickerStyle())
            }
            Divider()
#if os(iOS)
            VStack(alignment: .leading) {
                titleView("WheelDatePickerStyle()")
                datePicker()
                    .datePickerStyle(WheelDatePickerStyle())
            }
            Divider()
#else
            VStack(alignment: .leading) {
                titleView("StepperFieldDatePickerStyle()")
                datePicker()
                    .datePickerStyle(StepperFieldDatePickerStyle())
            }
            Divider()
            VStack(alignment: .leading) {
                titleView("FieldDatePickerStyle()")
                datePicker()
                    .datePickerStyle(FieldDatePickerStyle())
            }
#endif
        }
        .frame(maxWidth: 500)
        .padding()
    }
    
    public init() {}
    public var body: some View {
#if os(iOS)
        ScrollView {
            datePickerGroup
        }
#else
        datePickerGroup
#endif
    }
    
    private func datePicker() -> some View {
        DatePicker("Date",
                   selection: $date,
                   in: dateRange,
                   displayedComponents: [.date, .hourAndMinute])
    }
    
    private func titleView(_ title: String) -> some View {
        Text(title).font(.caption).opacity(0.5)
    }
}

struct P52_DatePicker_Previews: PreviewProvider {
    static var previews: some View {
        P52_DatePicker()
    }
}
