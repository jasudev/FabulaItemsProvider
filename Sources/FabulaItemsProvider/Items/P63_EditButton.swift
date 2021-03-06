//
//  P63_EditButton.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P63_EditButton: View {
    
    let foodStr: String = "ððððððððððŦððððĨ­ððĨĨðĨðððĨðĨĶðĨŽðĨðķðŦð―ðĨðŦð§ð§ðĨð ðĨðĨŊððĨðĨĻð§ðĨðģð§ðĨð§ðĨðĨĐðððĶīð­ððððŦðĨŠðĨð§ðŪðŊðŦðĨðĨðŦ"
    @State var foods = [String]()
    
    public init() {}
    public var body: some View {
        List {
            ForEach(self.foods, id: \.self) { food in
                Text(food)
            }
            .onDelete { offsets in
                self.foods.remove(atOffsets: offsets)
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                self.foods = self.foodStr.map { String($0) }
            }
        }
        
#if os(iOS)
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar {
            EditButton()
        }
#endif
    }
}

struct P63_EditButton_Previews: PreviewProvider {
    static var previews: some View {
        P63_EditButton()
    }
}
