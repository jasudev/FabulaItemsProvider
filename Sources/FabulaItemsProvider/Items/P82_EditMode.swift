//
//  P82_EditMode.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P82_EditMode: View {
#if os(iOS)
    let foodStr: String = "ððððððððððŦððððĨ­ððĨĨðĨðððĨðĨĶðĨŽðĨðķðŦð―ðĨðŦð§ð§ðĨð ðĨðĨŊððĨðĨĻð§ðĨðģð§ðĨð§ðĨðĨĐðððĶīð­ððððŦðĨŠðĨð§ðŪðŊðŦðĨðĨðŦ"
    @State var foods = [String]()
    @Environment(\.editMode) private var editMode: Binding<EditMode>?
    
    public init() {}
    public var body: some View {
        VStack {
            EditButton()
                .padding()
            List{
                ForEach(foods, id: \.self) { food in
                    Text("Food : \(food)")
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
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    if self.editMode?.wrappedValue == .active {
                        Button("Cancel") {
                            self.editMode?.animation().wrappedValue = .inactive
                        }
                        .foregroundColor(Color.red)
                    }
                }
            }
        }
        .padding()
    }
#else
    public init() {}
    public var body: some View {
        EmptyView()
    }
#endif
}

struct P82_EditMode_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            P82_EditMode()
        }
    }
}
