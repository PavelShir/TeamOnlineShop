//
//  Cart.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

import Foundation

struct CartItem: Equatable {
    let id: Int
    let title: String
    let price: Float
    let images: [String]
    var count: Int
    var selected: Bool = false
}

struct CartItemCell: Equatable {
    let id: Int
    let title: String
    let price: Float
    let images: [String]
    var count: Int
    let selected: Bool
    
    let increaseCounter: () -> Void
    let decreaseCounter: () -> Void
    let deleteItem: () -> Void
    
    init(
        item: CartItem,
        increaseCounter: @escaping () -> Void,
        decreaseCounter: @escaping () -> Void,
        deleteItem: @escaping () -> Void
    ) {
        self.id = item.id
        self.title = item.title
        self.price = item.price
        self.count = item.count
        self.images = item.images
        self.selected = item.selected
        self.increaseCounter = increaseCounter
        self.decreaseCounter = decreaseCounter
        self.deleteItem = deleteItem
    }
    
    static func == (lhs: CartItemCell, rhs: CartItemCell) -> Bool {
        lhs.id == rhs.id
    }
}

