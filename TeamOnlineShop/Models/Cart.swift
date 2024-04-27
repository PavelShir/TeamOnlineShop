//
//  Cart.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

import Foundation

struct Cart {
    let items: [CartItem]
    
    static func allItems() -> [CartItem] {
        [
            .init(id: 1, title: "Air pods max by Apple", price: 1999, count: 1),
            .init(id: 2, title: "Monitor LG 22' 4K 120fps", price: 299, count: 1),
            .init(id: 3, title: "Erphones for monitor", price: 99, count: 2)
        ]
    }
    
    static let sample = Self(items: Cart.allItems())
}

struct CartItem {
    
    let id: Int
    let title: String
    let price: Int
//    let images: [String]
    var count: Int
}


