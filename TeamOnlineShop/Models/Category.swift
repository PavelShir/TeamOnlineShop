//
//  Category.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation

struct CategoriesResponse: Codable {
    var results: [Category]
}

struct Category: Codable {
    let id: Int?
    let name: String
    let image: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
    }
    
    init(name: String, image: String) {
        self.id = nil
        self.name = name
        self.image = image
    }
    
    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
