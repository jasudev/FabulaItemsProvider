//
//  P245_Mirror.swift
//  
//
//  Created by jasu on 2022/04/30.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P245_Mirror: View {
    
    @StateObject var dumpState = DumpState()
    
    public init() {}
    public var body: some View {
        VStack {
            Text(dumpState.text)
                .font(.caption)
            Divider().frame(width: 44)
            Text("Hello, world!")
                .dump(dumpState)
                .background(Color.yellow)
                .dump(dumpState)
                .font(.title)
                .dump(dumpState)
        }
    }
    
    class DumpState: ObservableObject {
        @Published var count: Int = 0
        @Published var text: String = ""
    }
}

fileprivate
extension View {
    func dump(_ dumpState: P245_Mirror.DumpState) -> some View {
        return self.onAppear() {
            dumpState.count += 1
            dumpState.text += "\(dumpState.count). \(mirror(Mirror(reflecting: self).description))\n"
        }
    }
    
    private func mirror(_ text: String) -> String {
        text.replacingOccurrences(of: "Mirror for ", with: "")
    }
}

struct P245_Mirror_Previews: PreviewProvider {
    static var previews: some View {
        P245_Mirror()
    }
}
