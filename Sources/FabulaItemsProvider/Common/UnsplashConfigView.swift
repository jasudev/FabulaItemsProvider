//
//  UnsplashConfigView.swift
//  
//
//  Created by jasu on 2022/01/29.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import UnsplashProvider

public struct UnsplashConfigView: View {
    
    @AppStorage("unsplashAccessKey") var unsplashAccessKey: String = ""
    
    private var onChange: () -> Void
    public init(_ onChange: @escaping () -> Void) {
        self.onChange = onChange
        UPConfiguration.shared.accessKey = unsplashAccessKey.isEmpty ? "<YOUR_ACCESS_KEY>" : unsplashAccessKey
    }
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Unsplash Configuration")
                    .font(.caption)
                    .foregroundColor(Color.fabulaFore2)
                Spacer()
                Text("[Get access key](https://unsplash.com/oauth/applications)")
                    .font(.caption)
            }
            HStack {
                Text("Access Key :")
                    .foregroundColor(Color.fabulaFore1)
                ZStack {
                    if #available(macOS 12.0, *) {
                        TextField("", text: $unsplashAccessKey, prompt: Text("<YOUR_ACCESS_KEY>"))
                    } else {
                        TextField("", text: $unsplashAccessKey)
                    }
                }
                .onChange(of: unsplashAccessKey) { key in
                    UPConfiguration.shared.accessKey = key
                    if !key.isEmpty {
                        self.onChange()
                    }
                }
                .textFieldStyle(.roundedBorder)
                .foregroundColor(Color.fabulaFore1.opacity(0.6))
            }
            .font(.callout)
        }
        .padding(11)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.fabulaBackWB100.opacity(0.3))
        )
    }
}

struct UnsplashConfigView_Previews: PreviewProvider {
    static var previews: some View {
        UnsplashConfigView { }
    }
}

