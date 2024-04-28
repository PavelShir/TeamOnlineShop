//
//  User.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation

enum UserType: String, Codable {
    case user
    case manager
}
enum Location: String {
    case America
    case Europe
    case Russia
    case Other
}

struct User {
    let id: String
    var username: String = ""
    var email: String = ""
    var pass: String = ""
    var image: String?
    var type: String = UserType.user.rawValue
    var cart: [Product] = []
    var wishList: [Product] = []
    var location: String = Location.America.rawValue
    
}

extension User: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decode(String.self, forKey: .email)
        id = try container.decode(String.self, forKey: .id)
        image = try container.decode(String.self, forKey: .image)
        cart = try container.decode([Product].self, forKey: .cart)
        wishList = try container.decode([Product].self, forKey: .wishList)
        location = try container.decode(String.self, forKey: .location)
        type = try container.decode(String.self, forKey: .type)
    }
}

extension User {
    func toJSON() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}


