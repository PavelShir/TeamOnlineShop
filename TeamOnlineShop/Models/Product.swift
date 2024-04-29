//
//  Product.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation
import PlatziFakeStore

struct ProductsResponse: Codable {
    var results: [Product]?
}

struct Product: Codable, Equatable {
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
        
    init(
        id: Int,
        title: String,
        price: Int,
        description: String,
        images: [String],
        category: Category
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.images = images
        self.category = category
        self.count = 0
    }
    
    init(fromDTO product: PlatziFakeStore.Product) {
        self.id = product.id
        self.title = product.title
        self.price = product.price
        self.description = product.description
        self.images = product.images
        self.category = Category(fromDTO: product.category)
        self.count = 0
    }
}

extension Product: PickerViewRepresentable {
    var pickerViewTitle: String { return title }
}
