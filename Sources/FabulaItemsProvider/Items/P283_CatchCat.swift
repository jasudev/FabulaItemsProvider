//
//  P283_CatchCat.swift
//
//
//  Created by wooseob on 12/19/23.
//

import SwiftUI

public struct P283_CatchCat: View {
    @State var score = 0
    @State var offsetX : Double = .random(in: 0...1)
    @State var offsetY : Double = .random(in: 0...1)
    var animationDuration : Double = 1
    public var body: some View {
        
        Text("score : \(score)")
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
        GeometryReader { screen in
            Cat()
                .frame(width: 50, height: 50)
                .offset(x: screen.size.width * offsetX,
                        y: screen.size.height * offsetY)
                .onAppear {
                   runaway()
                }.onTapGesture {
                    score += 1
                }
        }
 
    }
    private func runaway() {
        DispatchQueue.main.asyncAfter(deadline: .now() +  1.0) {
            move()
            runaway()
        }

    }
    private func move() {
        withAnimation(.linear(duration: animationDuration)) {
            offsetY = .random(in: -0.5...0.5)
            offsetX = .random(in: -0.5...0.5)
        }
    }

}


fileprivate struct Cat: View {

    var body: some View {
        Image(systemName: "cat")
    }
}

#Preview {
    P283_CatchCat()
}
