//
//  P201_AlamofireBasic.swift
//  
//  Reference: https://bit.ly/3A4EkcD
//  Created by jasu on 2022/01/15.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import Combine
import Alamofire
import SDWebImageSwiftUI

public struct P201_AlamofireBasic: View {
    
    @StateObject private var viewModel = RandomUserViewModel()
    
    public init() {}
    public var body: some View {
        List(viewModel.randomUsers) { randomUser in
            RandomUserRowView(randomUser)
        }
        .frame(maxWidth: 500)
    }
}

//MARK: - UI
fileprivate
struct RandomUserRowView: View {
    
    var randomUser: RandomUser
    
    init(_ randomUser: RandomUser) {
        self.randomUser = randomUser
    }
    
    var body: some View {
        HStack {
            ProfileImageView(imageUrl: randomUser.profileImageUrl)
            Text(randomUser.description)
                .font(.title3)
                .bold()
                .lineLimit(2)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity, maxHeight: 55, alignment: .leading)
        .padding(.vertical, 6)
    }
}

fileprivate
struct ProfileImageView: View {
    
    var imageUrl: URL
    
    var body: some View {
        WebImage(url: imageUrl)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.fabulaPrimary, lineWidth: 2)
            )
    }
}

//MARK: - Model
fileprivate
struct RandomUserResponse: Codable, CustomStringConvertible {
    var results: [RandomUser]
    var info: ResponseInfo
    
    var description: String {
        return "results.count: \(results.count) / info: \(info.seed)"
    }
}

fileprivate
struct RandomUser: Codable, Identifiable, CustomStringConvertible {
    
    var id = UUID()
    var name: UserName
    var photo: UserPhoto
    
    var profileImageUrl: URL {
        get {
            URL(string: photo.medium)!
        }
    }
    
    var description: String {
        return name.description
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case photo = "picture"
    }
    
    static func getDummy() -> Self {
        return RandomUser(name: UserName.getDummy(), photo: UserPhoto.getDummy())
    }
}

fileprivate
struct UserName: Codable, CustomStringConvertible {
    
    var title: String
    var first: String
    var last: String
    
    var description: String {
        return "[\(title)] \(last) \(first)"
    }
    
    static func getDummy() -> Self {
        return UserName(title: "Fabula", first: "UI", last: "Swift")
    }
}

fileprivate
struct UserPhoto: Codable {
    
    var large: String
    var medium: String
    var thumbnail: String
    
    static func getDummy() -> Self {
        let path: String = "https://randomuser.me/api/portraits/women/10.jpg"
        return UserPhoto(large: path, medium: path, thumbnail: path)
    }
}

fileprivate
struct ResponseInfo: Codable {
    
    var seed: String
    var count: Int
    var page : Int
    var version: String
    
    private enum CodingKeys: String, CodingKey {
        case seed = "seed"
        case count = "results"
        case page = "page"
        case version = "version"
    }
}

//MARK: - ViewModel
fileprivate
class RandomUserViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    @Published var randomUsers = [RandomUser]()
    
    var baseUrl: String = "https://randomuser.me/api?results=100"
    
    init() {
        fetchRandomUsers()
    }
    
    func fetchRandomUsers() {
        AF.request(baseUrl)
            .publishDecodable(type: RandomUserResponse.self)
            .compactMap { $0.value }
            .map { $0.results }
            .sink { completion in
                print("completion", completion)
            } receiveValue: { receivedValue in
                self.randomUsers = receivedValue
            }
            .store(in: &subscription)
    }
}

struct P201_AlamofireBasic_Previews: PreviewProvider {
    static var previews: some View {
        P201_AlamofireBasic()
    }
}
