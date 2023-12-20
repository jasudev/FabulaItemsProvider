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
    @State var degree : Double = 0
    fileprivate var animationDuration : Double = 1
    fileprivate var cat = Cat()
    public var body: some View {
        
        Text("score : \(score)")
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
        GeometryReader { screen in
            cat
                .frame(width: 70, height: 70)
                .offset(x: screen.size.width * offsetX,
                        y: screen.size.height * offsetY)
                .rotationEffect(Angle(degrees: degree))
                .onAppear {
                   runaway()
                    withAnimation(.linear(duration: animationDuration * 3).repeatForever()) {
                        degree += 360
                    }
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
            offsetY = .random(in: -0.3...0.3)
            offsetX = .random(in: -0.3...0.3)
        }
    }

}


fileprivate struct Cat: View {
    
    @State var catImage = "cat"
    @State var isTapped = false
    var body: some View {
        if isTapped {
            Image(systemName: "cat.fill")
                .resizable()
        } else {
            Image(systemName: "cat")
                .resizable()
        }
        
    }
    
}

#Preview {
    P283_CatchCat()
}
