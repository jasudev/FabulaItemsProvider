//
//  SwiftUIView.swift
//
//
//  Created by Lee on 2022/08/30.
//

import SwiftUI

public struct P263_NavigationBar: View {
    
    @State private var centerText = ""
    @State private var showLeftAlert: Bool = false
    @State private var showRightAlert: Bool = false
    
    public var body: some View {
    #if os(iOS)
        NavigationView {
            Text(centerText)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Left") {
                            centerText = "Left Button Clicked"
                            showLeftAlert = true
                        }.alert(isPresented: $showLeftAlert) {
                            Alert(title: Text("Left"), message: Text("Button Clicked"), dismissButton: .default(Text("Dismiss")))
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        VStack{
                            Text("Title")
                                .font(.system(size: 20, weight: .bold))
                            Text("SubTitle")
                                .font(.system(size: 10))
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Right") {
                            centerText = "Right Button Clicked"
                            showRightAlert = true
                        }.alert(isPresented: $showRightAlert) {
                            Alert(title: Text("Right"), message: Text("Button Clicked"), dismissButton: .default(Text("Dismiss")))
                        
                        }
                    }
                }
        }
    #else
        EmptyView()
    #endif
    }
}

struct P263_NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        P263_NavigationBar()
    }
}
