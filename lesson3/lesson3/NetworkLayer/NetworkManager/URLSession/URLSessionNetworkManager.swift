//  URLSessionNetworkManager.swift
//  lesson3
//
// Created by Виталий  on 26.12.2021.
//

import Foundation

class URLSessionNetworkManager: NetworkManagerProtocol {

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    // MARK: Private properties
    private var urlSession: URLSession

    // MARK: NetworkManagerProtocol implementation
    func load(from url: URL, completion: @escaping (Data) -> Void) {
        urlSession.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            completion(data)
        }.resume()
    }

    func upload(data: Data, to url: URL, completion: ((Data) -> ())?) {
        var request = URLRequest(url: url)
        request.httpBody = data

        urlSession.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            completion?(data)
        }.resume()
    }
}