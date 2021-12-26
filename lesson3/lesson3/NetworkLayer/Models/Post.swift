//  Post.swift
//  lesson3
//
// Created by Виталий  on 27.12.2021.
//

import Foundation

struct Post: Codable {
    let id: Int?
    let title: String
    let body: String
    let userId: Int
}

extension Post {
    static func mock() -> Post {
        return Post(id: nil, title: "Test title", body: "At now we can end POST request", userId: 0)
    }
}