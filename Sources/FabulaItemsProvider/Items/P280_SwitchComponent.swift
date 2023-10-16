//
//  P280_SwitchComponent.swift
//
//
//  Created by jasu on 2023/10/15.
//  Copyright (c) 2023 jasu All rights reserved.
//

import SwiftUI

public struct P280_SwitchComponent: View {
    
    @State private var isOn: Bool = false
    
    public init() {}
    public var body: some View {
        Switch(isOn: $isOn) { value in
           print("Action: ", value)
        }
        .frame(width: 200, height: 125)
        .padding()
    }
}

struct P280_SwitchComponent_Previews: PreviewProvider {
    static var previews: some View {
        P280_SwitchComponent()
    }
}

//MARK: - Switch
fileprivate
struct Switch: View {
   
   @Binding var isOn: Bool
   var onTapReceive: ((Bool) -> Void)?
   @GestureState private var isTapped = false
   
   var backgroundColor: Color {
      isOn ? .fabulaPrimary : Color(hex: 0x333333)
   }
   
   var handleColor: Color {
      isOn ? Color(hex: 0xFFFFFF) : Color(hex: 0xDDDDDD)
   }
   
   var gesture: some Gesture {
      DragGesture(minimumDistance: 0)
         .updating($isTapped) { (_, isTapped, _) in
            isTapped = true
         }
         .onEnded { _ in
            isOn.toggle()
            onTapReceive?(isOn)
         }
   }
   
   var body: some View {
      switchUIView()
         .gesture(gesture)
         .animation(.default, value: isOn)
         .animation(.default, value: isTapped)
   }
   
   @ViewBuilder
   private func switchUIView() -> some View {
      GeometryReader { geo in
         let handleGap = geo.size.height * 0.075
         ZStack(alignment: isOn ? .trailing : .leading) {
            Capsule()
               .fill(backgroundColor)
            Capsule()
               .fill(handleColor)
               .padding(handleGap)
               .frame(width: handleWidth(geo.size))
               .shadow(color: Color.black.opacity(0.4),
                       radius: handleGap * 0.5,
                       x: 0,
                       y: 0)
         }
      }
      .frame(idealWidth: 51, idealHeight: 31)
   }
   
   private func handleWidth(_ size: CGSize) -> CGFloat {
      let w = size.width
      let h = size.height
      return isTapped ? h + (w - h) * 0.3 : h
   }
}
