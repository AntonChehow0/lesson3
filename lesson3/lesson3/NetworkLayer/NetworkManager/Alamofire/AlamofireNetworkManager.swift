//  AlamofireNetworkManager.swift
//  lesson3
//
// Created by Виталий  on 27.12.2021.
//

import Foundation
import Alamofire

class AlamofireNetworkManager: NetworkManagerProtocol {

    // MARK: NetworkManagerProtocol implementation
    func load(from url: URL, completion: @escaping (Data) -> ()) {
        AF.request(url).responseData { response in
            guard let data = response.data else { return }
            completion(data)
        }
    }

    func upload(data: Data, to url: URL, completion: ((Data) -> ())?) {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String : Any] else { return }
        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).responseData { response in
            guard let data = response.data else { return }
            completion?(data)
        }
    }
}