//
//  P203_AlamofirePagination.swift
//  
//  Reference: https://bit.ly/3A4EkcD
//  Created by jasu on 2022/01/15.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import Combine
import Alamofire
import SDWebImageSwiftUI

struct P203_AlamofirePagination: View {
    
    @StateObject private var viewModel = RandomUserViewModel()
    
    public init() {}
    public var body: some View {
        ZStack(alignment: .bottom) {
//#if os(iOS)
//            List(viewModel.randomUsers) { randomUser in
//                RandomUserRowView(randomUser)
//                    .onAppear { self.fetchMore(randomUser) }
//            }
//#else
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.randomUsers) { randomUser in
                        RandomUserRowView(randomUser)
                            .onAppear { self.fetchMore(randomUser) }
                    }
                }
                .padding()
            }
//#endif
            
            if viewModel.isLoading {
                BottomProgressView()
            }
        }
        .frame(maxWidth: 500)
    }
    
    private func fetchMore(_ randomUser: RandomUser) {
        if viewModel.randomUsers.last == randomUser {
            viewModel.fetchMoreActionSubject.send()
        }
    }
}

//MARK: - UI
fileprivate
struct BottomProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(
                CircularProgressViewStyle(tint: Color.fabulaPrimary)
            )
#if os(iOS)
            .scaleEffect(1.5)
#endif
    }
}

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

extension RandomUser: Equatable {
    static func == (lhs: RandomUser, rhs: RandomUser) -> Bool {
        lhs.id == rhs.id
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
struct ResponseInfo: Codable, CustomStringConvertible {
    
    var seed: String
    var count: Int
    var page : Int
    var version: String
    
    var description: String {
        return "seed: \(seed) / version: \(version) / count: \(count), page: \(page)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case seed = "seed"
        case count = "results"
        case page = "page"
        case version = "version"
    }
}

//MARK: - ViewModel
fileprivate
let BASE_URL = "https://randomuser.me/api/"

fileprivate
enum RandomUserRouter: URLRequestConvertible {
    case getUsers(page: Int = 0, results: Int = 30)
    
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var endPoint: String {
        switch self {
        case .getUsers:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers: return .get
        }
    }

    var parameters: Parameters {
        switch self {
        case let .getUsers(page, results):
            var params = Parameters()
            params["page"]  = page
            params["results"] = results
            params["seed"] = "abc"
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        
        switch self {
        case .getUsers:
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        return request
    }
    
}

fileprivate
class RandomUserViewModel: ObservableObject {
    
    var subscription = Set<AnyCancellable>()
    var fetchActionSubject = PassthroughSubject<(), Never>()
    var fetchMoreActionSubject = PassthroughSubject<(), Never>()
    
    @Published var randomUsers = [RandomUser]()
    @Published var isLoading: Bool = false
    @Published var pageInfo: ResponseInfo? {
        didSet {
            print("pageInfo: \(String(describing: pageInfo))")
        }
    }
    
    init() {
        fetchRandomUsers()
        
        fetchActionSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.fetchRandomUsers()
        }
        .store(in: &subscription)
        
        fetchMoreActionSubject.sink { [weak self] _ in
            guard let self = self else { return }
            if !self.isLoading {
                self.fetchMore()
            }
        }
        .store(in: &subscription)
    }
    
    private func fetchRandomUsers() {
        self.randomUsers = []
        fetchLoad(page: 1)
    }
    
    private func fetchMore() {
        guard let currentPage = pageInfo?.page else { return }
        
        let pageToLoad = currentPage + 1
        fetchLoad(page: pageToLoad)
    }
    
    private func fetchLoad(page: Int) {
        self.isLoading = true
        AF.request(RandomUserRouter.getUsers(page: page))
            .publishDecodable(type: RandomUserResponse.self)
            .compactMap { $0.value }
            .sink { completion in
                print("completion", completion)
                self.isLoading = false
            } receiveValue: { receivedValue in
                self.randomUsers += receivedValue.results
                self.pageInfo = receivedValue.info
            }
            .store(in: &subscription)
    }
}

struct P203_AlamofirePagination_Previews: PreviewProvider {
    static var previews: some View {
        P203_AlamofirePagination()
    }
}
