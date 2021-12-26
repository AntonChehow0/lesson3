//  JsonDecoderBaseDecoder.swift
//  lesson3
//
// Created by Виталий  on 26.12.2021.
//

import Foundation

class JsonDecoderBaseDecoder: DecoderProtocol {

    // MARK: DecoderProtocol
    func decodeToUsers(data: Data) -> [User] {
        return (try? JSONDecoder().decode([User].self, from: data)) ?? []
    }
}