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

    init(networkManager: NetworkManagerProtocol = URLSessionNetworkManager(),
         decoderStrategy: DecodingStrategy = .jsonDecoder) {
        self.networkManager = networkManager
        self.decoder = decoderStrategy.rawValue
    }

    // MARK: Private properties
    private let networkManager: NetworkManagerProtocol
    private let decoder: DecoderProtocol

    private let baseUrl = "https://jsonplaceholder.typicode.com/"

    private enum MethodPath: String {
        case users = "users"
    }

    // MARK: ApiManagerProtocol implementation
    func loadUsers(completion: @escaping ([User]) -> ()) {
        guard let url = URL(string: "\(baseUrl)\(MethodPath.users.rawValue)") else { return }

        networkManager.load(from: url) { [weak self] data in
            let users = self?.decoder.decodeToUsers(data: data) ?? []
            completion(users)
        }
    }
}