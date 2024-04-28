//
//  Category.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation
import PlatziFakeStore

struct CategoriesResponse: Codable {
    var results: [Category]
}

struct Category: Codable, Equatable {
    let id: Int
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
    
    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    init(fromDTO category: PlatziFakeStore.Category) {
        self.id = category.id
        self.name = category.name
        self.image = category.image
    }
}

extension Category: PickerViewRepresentable {
    var pickerViewTitle: String { return name }
}
