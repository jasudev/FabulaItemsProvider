//
//  P38_ActionSheet.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P38_ActionSheet: View {
    
    @State private var showActionSheet = false
    @State private var stateText: String = "-"
    
    public init() {}
    public var body: some View {
#if os(iOS)
        VStack{
            Text(stateText)
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Title"),
                                message: Text("This is a ActionSheet message"),
                                buttons: [
                                    .default(
                                        Text("Ok"), action: {
                                            stateText = "Ok"
                                        }
                                    ),
                                    .cancel(
                                        Text("Cancel"), action: {
                                            stateText = "Cancel"
                                        }
                                    )])
                }
            Divider()
            Text("Show Action Sheet")
                .onTapGesture {
                    showActionSheet = true
                }
        }
        .padding()
#else
        EmptyView()
#endif
    }
}

struct P38_ActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        P38_ActionSheet()
    }
}
