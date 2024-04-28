//
//  User.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation

enum UserRole: String, Codable {
    case user = "Клиент"
    case manager = "Менеджер"
}

struct User {
    let id: String
    var username: String = ""
    var email: String = ""
    var image: String?
    var role: String = UserRole.user.rawValue
    var cart: [Product] = []
    var wishList: [Product] = []
    var location: String = Address.usa.rawValue
    
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
        role = try container.decode(String.self, forKey: .role)
    }
}

extension User {
    func toJSON() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}


