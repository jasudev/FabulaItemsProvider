//
//  P215_UnsplashProvider.swift
//  
//  Package : https://github.com/jasudev/UnsplashProvider.git
//  Created by jasu on 2022/01/30.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import UnsplashProvider
import SDWebImageSwiftUI

public struct P215_UnsplashProvider: View {
    
    private let provider = UnsplashProvider()
    
    @StateObject var photo = UPPhotoStore()
    @StateObject var photos = UPPhotosStore()
    @StateObject var randomPhotos = UPRandomPhotosStore()
    @StateObject var searchPhotos = UPSearchPhotosStore()
    @StateObject var searchUsers = UPSearchUsersStore()
    
    public init() {}
    public var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                UnsplashConfigView {
                    fetchPhotos()
                }
                .padding()
                List {
                    Section {
                        RowPhotoView(photo: photo.photo)
                    } header: {
                        Text("UPPhotoStore")
                    }
                    
                    Section {
                        ForEach(photos.photos) { photo in
                            RowPhotoView(photo: photo)
                        }
                    } header: {
                        Text("UPPhotosStore")
                    }
                    
                    Section {
                        ForEach(randomPhotos.photos) { photo in
                            RowPhotoView(photo: photo)
                        }
                    } header: {
                        Text("UPRandomPhotosStore")
                    }
                    
                    Section {
                        ForEach(searchPhotos.photos) { photo in
                            RowPhotoView(photo: photo)
                        }
                    } header: {
                        Text("UPSearchPhotosStore")
                    }
                    
                    Section {
                        ForEach(searchUsers.users) { user in
                            RowUserView(user: user)
                        }
                    } header: {
                        Text("UPSearchUsersStore")
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal)
            }
        }
        .onAppear {
            fetchPhotos()
        }
    }
    
    private func fetchPhotos() {
        photo.fetchPhoto(id: "F3OvjNcF5Xg")
        photos.fetchPhotos(perPage: 10, orderBy: .popular)
        randomPhotos.fetchPhotos(query: "cat", count: 10)
        searchPhotos.fetchSearchPhotos(query: "colorful", perPage: 10, orientation: .squarish)
        searchUsers.fetchSearchUsers(query: "jasudev", perPage: 10)
    }
}

fileprivate
struct RowPhotoView: View {
    
    let photo: UPPhoto?
    
    var body: some View {
        if let photo = photo {
            ZStack {
                WebImage(url: photo.urls.size(.regular))
                    .resizable()
                    .placeholder {
                        Rectangle()
                            .fill(photo.color)
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .listRowInsets(EdgeInsets())
                    .clipShape(Rectangle())
            }
            .listRowInsets(EdgeInsets())
        }else {
            EmptyView()
        }
    }
}

fileprivate
struct RowUserView: View {
    
    let user: UPUser?
    
    var body: some View {
        if let user = user {
            WebImage(url: user.profileUrls.large)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .listRowInsets(EdgeInsets())
                .clipShape(Rectangle())
        }else {
            EmptyView()
        }
    }
}

struct P215_UnsplashProvider_Previews: PreviewProvider {
    static var previews: some View {
        P215_UnsplashProvider()
    }
}
