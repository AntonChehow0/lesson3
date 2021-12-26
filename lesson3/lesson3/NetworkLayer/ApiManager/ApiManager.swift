//  ApiManager.swift
//  lesson3
//
// Created by Виталий  on 26.12.2021.
//

import Foundation

class ApiManager: ApiManagerProtocol {

    init(networkManager: NetworkManagerProtocol = URLSessionNetworkManager(),
         decoder: DecoderProtocol = JsonSerializationDecoder()) {
        self.networkManager = networkManager
        self.decoder = decoder
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