//
//  P71_Calendar.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P71_Calendar: View {
    
    @Environment(\.calendar) private var calendar: Calendar
    
    public init() {}
    public var body: some View {
        VStack {
            Text(calendar.description).padding()
            KoreaView().padding()
                .environment(\.calendar, {
                    let calendar = Calendar(identifier: .japanese)
                    return calendar
                }())
        }
    }
}

fileprivate
struct KoreaView: View {
    
    @Environment(\.calendar) private var calendar: Calendar
    
    var body: some View {
        Text(calendar.description)
    }
}

struct P71_Calendar_Previews: PreviewProvider {
    static var previews: some View {
        P71_Calendar()
    }
}
