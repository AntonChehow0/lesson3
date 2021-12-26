//  JsonSerializationDecoder.swift
//  lesson3
//
// Created by Виталий  on 26.12.2021.
//

import Foundation

class JsonSerializationDecoder: DecoderProtocol {

    // MARK: DecoderProtocol implementation
    func decodeToUsers(data: Data) -> [User] {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else { return [] }

        return json.compactMap({ decode(dict: $0) })
    }

    func decodeToPost(data: Data) -> Post? {
        nil
    }

    // MARK: Private funcs
    private func decode(dict: [String: Any]) -> User? {
        guard let id = dict["id"] as? Int,
              let name = dict["name"] as? String,
              let username = dict["username"] as? String,
              let email = dict["email"] as? String,
              let addressDict = dict["address"] as? [String: Any],
              let address: Address = decode(dict: addressDict),
              let phone = dict["phone"] as? String,
              let website = dict["website"] as? String,
              let companyDict = dict["company"] as? [String: Any],
              let company: Company = decode(dict: companyDict)
        else { return nil }

        return User(id: id,
                    name: name,
                    username: username,
                    email: email,
                    address: address,
                    phone: phone,
                    website: website,
                    company: company)
    }

    private func decode(dict: [String: Any]) -> Address? {
        guard let street = dict["street"] as? String,
              let suite = dict["suite"] as? String,
              let city = dict["city"] as? String,
              let zipcode = dict["zipcode"] as? String,
              let geoDict = dict["geo"] as? [String : Any],
              let geo: Geo = decode(dict: geoDict)

        else { return nil }

        return Address(street: street,
                       suite: suite,
                       city: city,
                       zipcode: zipcode,
                       geo: geo)
    }

    private func decode(dict: [String: Any]) -> Geo? {
        guard let lat = dict["lat"] as? String,
              let lng = dict["lng"] as? String
        else { return nil }

        return Geo(lat: lat, lng: lng)
    }

    private func decode(dict: [String: Any]) -> Company? {
        guard let name = dict["name"] as? String,
              let catchPhrase = dict["catchPhrase"] as? String,
              let bs = dict["bs"] as? String
        else { return nil }

        return Company(name: name, catchPhrase: catchPhrase, bs: bs)
    }
}