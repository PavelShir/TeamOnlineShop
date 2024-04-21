//
//  Product.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation

struct ProductsResponse: Codable {
    var results: [Product]?
}

struct Product: Codable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let images: [String]
    let category: Category
    var count: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case images
        case category
        case count
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        price = try container.decode(Int.self, forKey: .price)
        description = try container.decode(String.self, forKey: .description)
        images = try container.decode([String].self, forKey: .images)
        category = try container.decode(Category.self, forKey: .category)
        count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
    }
}
