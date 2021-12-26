//  DecoderProtocol.swift
//  lesson3
//
// Created by Виталий  on 26.12.2021.
//

import Foundation

protocol DecoderProtocol {
    func decodeToUsers(data: Data) -> [User]
    func decodeToPost(data: Data) -> Post?
}