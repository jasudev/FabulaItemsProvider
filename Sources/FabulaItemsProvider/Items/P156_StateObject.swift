//
//  P156_StateObject.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P156_StateObject: View {
    
    class ViewModel: ObservableObject {
        @Published var value: Bool = false
    }
    
    @ObservedObject var viewModel = ViewModel()
    
    public init() {}
    public var body: some View {
        VStack {
            DetailView()
            Divider().padding()
            Toggle("Toggle", isOn: $viewModel.value)
        }
        .environmentObject(viewModel)
        .padding()
        .frame(maxWidth: 500)
    }
}

fileprivate
extension P156_StateObject {
    
    struct DetailView: View {
        
        @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            Text("The value is: ") +
            Text("\(String(describing: viewModel.value))")
                .foregroundColor(viewModel.value ? Color.green : Color.gray)
        }
    }
}


struct P156_StateObject_Previews: PreviewProvider {
    static var previews: some View {
        P156_StateObject()
    }
}
