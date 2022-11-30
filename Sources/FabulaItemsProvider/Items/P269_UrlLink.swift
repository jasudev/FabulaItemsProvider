//
//  P269_UrlLink.swift
//
//
//  Created by soccer01 on 2022/11/06.
//  Copyright (c) 2022 soccer01 All rights reserved.
//

import SwiftUI
import SafariServices

public struct P269_UrlLink: View {
    @Environment(\.openURL) var openURL
    @State private var isShowSFView = false
    private var url = URL(string: "https://www.google.com")
    
    public init() {}
    public var body: some View {
        VStack {
            Link(destination: url!) {
                HStack {
                    Text("Link")
                }.foregroundColor(Color.fabulaPrimary)
            }.padding()
            
            Button() {
                openURL(url!)
            } label: {
                Text("openURL")
                    .foregroundColor(Color.fabulaPrimary)
            }.buttonStyle(.borderless)
                .padding()
            
            #if os(iOS)
            Button {
                isShowSFView.toggle()
            } label: {
                Text("SFSafariViewController")
                    .foregroundColor(Color.fabulaPrimary)
            }.fullScreenCover(isPresented: $isShowSFView) {
                SafariView(url: url!)
            }.buttonStyle(.borderless)
                .padding()
            #endif
        }
    }
}

#if os(iOS)
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
}
#endif



public struct P269_UrlLink_Previews: PreviewProvider {
    public static var previews: some View {
        P269_UrlLink()
    }
}
