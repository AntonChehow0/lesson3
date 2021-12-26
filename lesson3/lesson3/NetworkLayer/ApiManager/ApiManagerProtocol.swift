//  ApiManagerProtocol.swift
//  lesson3
//
// Created by Виталий  on 26.12.2021.
//

import Foundation

protocol ApiManagerProtocol {
    func loadUsers(completion: @escaping (_ users: [User]) -> Void)
    func create(newPost: Post, completion: @escaping  (_ post: Post) -> Void)
}