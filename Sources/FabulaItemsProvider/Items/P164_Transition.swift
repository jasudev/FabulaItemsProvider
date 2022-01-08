//
//  P164_Transition.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P164_Transition: View {

    var asymTransition: AnyTransition {
        let insertion = AnyTransition.offset(x: 0, y: 200).combined(with: .scale)
        let removal = AnyTransition.move(edge: .leading).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    public init() {}
    public var body: some View {
        VStack {
            TransitionView {
                Text("Combined")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.fabulaPrimary)
                    .transition(AnyTransition.slide.combined(with: .scale))
            }
            TransitionView {
                Text("Asymmetric")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.fabulaPrimary)
                    .transition(asymTransition)
            }
            
            TransitionView {
                Text("ViewModifier")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.fabulaPrimary)
                    .transition(.customScale)
            }
        }
    }
}

fileprivate
extension P164_Transition {
    struct TransitionView<Content: View>: View {
        
        @State private var showText: Bool = false
        let content: () -> Content
        
        var body: some View {
            VStack {
                if showText {
                    content()
                }
                
                Button {
                    withAnimation {
                        showText.toggle()
                    }
                } label: {
                    Text("Display Text On / Off")
                        .padding()
                        .background(Color.fabulaPrimary)
                        .foregroundColor(Color.white)
                        .clipShape(Capsule())
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

fileprivate
struct CustomScaleModifier: ViewModifier {
    let scale: CGFloat
    func body(content: Content) -> some View {
        content.scaleEffect(scale)
    }
}

fileprivate
extension AnyTransition {
    static var customScale: AnyTransition {
        AnyTransition.modifier(active: CustomScaleModifier(scale: 0), identity: CustomScaleModifier(scale: 1))
    }
}

struct P164_Transition_Previews: PreviewProvider {
    static var previews: some View {
        P164_Transition()
    }
}
