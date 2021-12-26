//  NetworkManagerProtocol.swift
//  lesson3
//
// Created by Виталий  on 26.12.2021.
//

import Foundation

protocol NetworkManagerProtocol {
    func load(from url: URL, completion: @escaping (Data) -> Void)
    func upload(data: Data, to url: URL, completion: @escaping (Data) -> Void)
}