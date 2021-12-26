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
}