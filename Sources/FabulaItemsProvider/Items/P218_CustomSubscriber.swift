//
//  P218_CustomSubscriber.swift
//  
//
//  Created by jasu on 2022/02/02.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import Combine

public struct P218_CustomSubscriber: View {
    
    fileprivate
    let subscriber = CustomSubscriber()
    let publisher = ["A", "B", "C", "D", "E", "F", "G"].publisher
    
    @State private var value: String = ""
    
    public init() {}
    public var body: some View {
        Text("\(value)")
            .onAppear {
                publisher.subscribe(subscriber)
                let _ = publisher.sink { _ in
                    self.value += "Publication of all data is complete.\n"
                } receiveValue: { value in
                    self.value += "Receive: \(value)\n"
                }
            }
    }
}

fileprivate
class CustomSubscriber: Subscriber {
    
    typealias Input = String // success type
    typealias Failure = Never // failure type
    
    func receive(completion: Subscribers.Completion<Failure>) {
        print("Publication of all data is complete.")
    }
    func receive(subscription: Subscription) {
        print("Start subscribing to data.")
        subscription.request(.unlimited)
    }
    func receive(_ input: Input) -> Subscribers.Demand {
        print("Receive: ", input)
        return .none
    }
}

struct P218_CustomSubscriber_Previews: PreviewProvider {
    static var previews: some View {
        P218_CustomSubscriber()
    }
}
