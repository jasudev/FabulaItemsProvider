//
//  P139_ObservedObject.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P139_ObservedObject: View {

    @StateObject var dataModel = DataModel()
    
    public init() {}
    public var body: some View {
        VStack {
            Text(dataModel.cityName)
                .font(.title)
                .foregroundColor(Color.fabulaPrimary)
            Divider().frame(width: 44).padding()
            InputView(dataModel: dataModel)
        }
        .padding()
        .frame(maxWidth: 500)
        .animation(.easeInOut, value: dataModel.cityName)
    }
}

extension P139_ObservedObject {
    
    class DataModel: ObservableObject {
        @Published var cityName: String = "Busan"
    }
    
    struct InputView: View {
        @ObservedObject var dataModel: DataModel
        
        var body: some View {
            TextField("Enter city name", text: $dataModel.cityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct P139_ObservedObject_Previews: PreviewProvider {
    static var previews: some View {
        P139_ObservedObject()
    }
}
