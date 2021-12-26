//  ApiManager.swift
//  lesson3
//
// Created by Виталий  on 26.12.2021.
//

import Foundation

class ApiManager: ApiManagerProtocol {

    init(networkManager: NetworkManagerProtocol = URLSessionNetworkManager()) {
        self.networkManager = networkManager
    }

    // MARK: Private properties
    private let networkManager: NetworkManagerProtocol
    let baseUrl = "https://jsonplaceholder.typicode.com/"

    private enum MethodPath: String {
        case users = "users"
    }

    // MARK: ApiManagerProtocol implementation
    func loadUsers(completion: @escaping ([User]) -> ()) {
        guard let url = URL(string: "\(baseUrl)\(MethodPath.users.rawValue)") else { return }
        print(url)

        networkManager.load(from: url) { data in
            guard let users = try? JSONDecoder().decode([User].self, from: data) else { return }
            completion(users)
        }
    }
}