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
    let id: Int?
    let title: String
    let price: Int
    let description: String
    let images: [String]
    let category: Category?
    let categoryId: Int?
    var count: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case images
        case category
        case categoryId
        case count
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        price = try container.decode(Int.self, forKey: .price)
        description = try container.decode(String.self, forKey: .description)
        images = try container.decode([String].self, forKey: .images)
        category = try container.decodeIfPresent(Category.self, forKey: .category)
        categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
        count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
    }
    
    init(
        title: String,
        price: Int,
        description: String,
        images: [String],
        categoryId: Int
    ) {
        self.id = nil
        self.title = title
        self.price = price
        self.description = description
        self.images = images
        self.categoryId = categoryId
        self.count = 0
        self.category = nil
    }
        
    init(
        id: Int,
        title: String,
        price: Int,
        description: String,
        images: [String],
        category: Category,
        categoryId: Int
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.images = images
        self.category = category
        self.categoryId = categoryId
        self.count = 0
    }
}
