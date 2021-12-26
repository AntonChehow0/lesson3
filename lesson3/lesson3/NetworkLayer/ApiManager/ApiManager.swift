//  ApiManager.swift
//  lesson3
//
// Created by Виталий  on 26.12.2021.
//

import Foundation

class ApiManager: ApiManagerProtocol {

    enum DecodingStrategy: RawRepresentable {
        init?(rawValue: DecoderProtocol) {
            return nil
        }

        typealias RawValue = DecoderProtocol
        case jsonDecoder
        case jsonSerialization

        var rawValue: DecoderProtocol {
            switch self {
            case .jsonDecoder: return  JsonDecoderBaseDecoder()
            case .jsonSerialization: return  JsonSerializationDecoder()
            }
        }
    }

    enum NetworkManagerStrategy: RawRepresentable {
        init?(rawValue: NetworkManagerProtocol) { nil }
        typealias RawValue = NetworkManagerProtocol

        case urlSession
        case alamofire

        var rawValue: NetworkManagerProtocol {
            switch self {
            case .urlSession: return URLSessionNetworkManager()
            case .alamofire: return AlamofireNetworkManager()
            }
        }
    }

    init(networkManagerStrategy: NetworkManagerStrategy = .alamofire,
         decoderStrategy: DecodingStrategy = .jsonDecoder,
         encoder: EncoderProtocol = JSONEncoder()) {
        self.networkManager = networkManagerStrategy.rawValue
        self.decoder = decoderStrategy.rawValue
        self.encoder = encoder
    }

    // MARK: Private properties
    private let networkManager: NetworkManagerProtocol
    private let decoder: DecoderProtocol
    private let encoder: EncoderProtocol

    private let baseUrl = "https://jsonplaceholder.typicode.com/"

    private enum MethodPath: String {
        case users = "users"
        case posts
    }

    // MARK: ApiManagerProtocol implementation
    func loadUsers(completion: @escaping ([User]) -> ()) {
        guard let url = URL(string: "\(baseUrl)\(MethodPath.users.rawValue)") else { return }

        networkManager.load(from: url) { [weak self] data in
            let users = self?.decoder.decodeToUsers(data: data) ?? []
            completion(users)
        }
    }

    func create(newPost: Post, completion: @escaping (Post) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(MethodPath.posts.rawValue)"),
              let data = try? encoder.encode(newPost)
        else { return }

        networkManager.upload(data: data, to: url) { [weak self] data in
            guard let createdPost = self?.decoder.decodeToPost(data: data) else { return }
            completion(createdPost)
        }
    }
}