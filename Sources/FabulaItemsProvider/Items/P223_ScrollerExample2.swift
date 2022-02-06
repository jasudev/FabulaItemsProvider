//
//  P223_ScrollerExample2.swift
//  
//  Package : https://github.com/jasudev/Scroller.git
//  Created by jasu on 2022/02/04.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import UnsplashProvider
import SDWebImageSwiftUI
import Scroller

public struct P223_ScrollerExample2: View {
    
    private let provider = UnsplashProvider()
    private let query: String = "Travel"
    @StateObject var searchPhotos = UPSearchPhotosStore()
    @State private var scrollValue: CGFloat = 0
    
    public init() {}
    public var body: some View {
        VStack(spacing: 0) {
            UnsplashConfigView {
                fetchPhotos()
            }
            .padding()
            Scroller(.horizontal, showsIndicators: true, value: $scrollValue) {
                ForEach(searchPhotos.photos) { photo in
                    GeometryReader { proxy in
                        RowPhotoView(photo: photo, value: proxy.scrollerValue(.horizontal))
                    }
                }
            } lastContent: {
                Text("Search by keyword \"\(query)\"")
                    .font(.title)
            }
        }
        .onAppear {
            fetchPhotos()
        }
    }
    
    private func fetchPhotos() {
        searchPhotos.fetchSearchPhotos(query: query, perPage: 10)
    }
}

fileprivate
struct RowPhotoView: ScrollerContent {
    
    let photo: UPPhoto?
    var value: CGFloat
    
    var body: some View {
        if let photo = photo {
            GeometryReader { proxy in
                ZStack {
                    WebImage(url: photo.urls.size(.regular))
                        .resizable()
                        .placeholder {
                            Rectangle()
                                .fill(photo.color)
                        }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .clipped()
                    CaptionView(user: photo.user)
                }
                .listRowInsets(EdgeInsets())
                .opacity(1.0 - value)
                .scaleEffect(1 - value)
                .offset(x: (proxy.size.width * 0.5) * value)
            }
        }else {
            EmptyView()
        }
    }
}

fileprivate
struct CaptionView: View {
    
    @Environment(\.openURL) var openURL
    let user: UPUser?
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                if let user = user {
                    HStack(spacing: 0) {
                        Text("Photo by ")
                        Button {
                            openURL(user.linkUrls.html)
                        } label: {
                            Text("\(user.name ?? "")")
                                .underline()
                        }
                        Text(" on ")
                        Button {
                            if let url = URL(string: "https://unsplash.com") {
                                openURL(url)
                            }
                        } label: {
                            Text("Unsplash")
                                .underline()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.6))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(Color.black.opacity(0.8))
                    .padding(.bottom, 10)
#if os(macOS)
                    .padding(.trailing, 16)
#endif
                    .clipped()
                }else {
                    EmptyView()
                }
            }
        }
    }
}

struct P223_ScrollerExample2_Previews: PreviewProvider {
    static var previews: some View {
        P223_ScrollerExample2()
    }
}
