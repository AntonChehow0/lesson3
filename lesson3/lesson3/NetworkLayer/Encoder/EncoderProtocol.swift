//  EncoderProtocol.swift
//  lesson3
//
// Created by Виталий  on 27.12.2021.
//

import Foundation

protocol EncoderProtocol {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: EncoderProtocol {}