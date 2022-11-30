//
//  P268_ShareSheet.swift
//
//
//  Created by soccer01 on 2022/11/05.
//  Copyright (c) 2022 soccer01 All rights reserved.
//

import SwiftUI

public struct P268_ShareSheet: View {
    
    private let shareItem = URL(string: "https://www.google.com")
    
    public init() {}
    public var body: some View {
        #if os(iOS)
            if #available(iOS 16.0, *) {
                VStack {
                    if let shareItem = shareItem {
                        ShareLink(item: shareItem)
                    }
                }.padding()
            } else {
                Button(action: sheet) {
                    Text("Share")
                }
            }
        #else
        VStack {
            NSSharingService.submenu(shareItem: shareItem!)
                .frame(width: 40, height: 40)
                .padding()
        }
        #endif
    }
    
    #if os(iOS)
    private func sheet() {
        guard let url = shareItem else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        let scenes = UIApplication.shared.connectedScenes
        let scene = scenes.first { $0.activationState == .foregroundActive }
        
        if let windowScene = scene as? UIWindowScene {
            windowScene.keyWindow?.rootViewController?.present(activityVC, animated: true)
        }
    }
    #endif
}

#if os(macOS)
extension NSSharingService {
    private static let items = NSSharingService.sharingServices(forItems: [""])
    static func submenu(shareItem: Any) -> some View {
        return MenuButton(label: Text("Share")) {
            ForEach(items, id: \.title) { item in
                Button(action: { item.perform(withItems: [shareItem]) }) {
                    Image(nsImage: item.image)
                    Text(item.title)
                }
            }
        }.menuButtonStyle(BorderlessButtonMenuButtonStyle())
    }
}
#endif

struct P268_ShareSheet_Previews: PreviewProvider {
    static var previews: some View {
        P268_ShareSheet()
    }
}
