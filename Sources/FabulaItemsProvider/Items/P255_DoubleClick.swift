//
//  P255_DoubleClick.swift
//  
//
//  Created by jasu on 2022/05/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

#if os(macOS)
public struct P255_DoubleClick: View {

    @State private var shapeIndex: Int = 0

    private var tap0: some Gesture {
        TapGesture(count: 2)
            .onEnded {
                self.shapeIndex = 0
            }
    }

    private var tap1: some Gesture {
        TapGesture(count: 2)
            .modifiers([.command])
            .onEnded {
                self.shapeIndex = 1
            }
    }

    private var tap2: some Gesture {
        TapGesture(count: 2)
            .modifiers([.option])
            .onEnded {
                self.shapeIndex = 2
            }
    }

    private var tap3: some Gesture {
        TapGesture(count: 2)
            .modifiers([.control])
            .onEnded {
                self.shapeIndex = 3
            }
    }

    private var tap4: some Gesture {
        TapGesture(count: 2)
            .modifiers([.control, .option])
            .onEnded {
                self.shapeIndex = 4
            }
    }

    private var tap5: some Gesture {
        TapGesture(count: 2)
            .modifiers([.control, .option, .command])
            .onEnded {
                self.shapeIndex = 5
            }
    }

    public init() {}
    public var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 11).fill(Color.fabulaFore1)
                    .frame(width: 100, height: 100)
                // The order in which the gestures are added is important. If tab0 is placed first, the tab1,2,3,4,5 gestures will never be triggered.
                    .gesture(tap5)
                    .gesture(tap4)
                    .gesture(tap3)
                    .gesture(tap2)
                    .gesture(tap1)
                    .gesture(tap0)

                Text("\(self.shapeIndex)")
                    .foregroundColor(Color.fabulaPrimary)
                    .font(.title)
                    .bold()
            }

            Divider()

            Text("Double Click ⟶ 0")
            Text("Double Click + CMD ⟶ 1")
            Text("Double Click + ALT ⟶ 2")
            Text("Double Click + CTRL ⟶ 3")
            Text("Double Click + CTRL + ALT ⟶ 4")
            Text("Double Click + CTRL + ALT + CMD ⟶ 5")

        }
        .font(.callout)
        .foregroundColor(Color.fabulaFore2)
    }
}
#else
public struct P255_DoubleClick: View {
    public init() {}
    public var body: some View {
        EmptyView()
    }
}
#endif

struct P255_DoubleClick_Previews: PreviewProvider {
    static var previews: some View {
        P255_DoubleClick()
    }
}
