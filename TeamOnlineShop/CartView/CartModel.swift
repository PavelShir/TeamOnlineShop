//
//  CartModel.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

struct CartModel {
    let title: String
    let price: String
    let amount: Int
}

struct Cart {
    static func allItems() -> [CartModel] {
        [
            .init(title: "Air pods max by Apple", price: "1999,99", amount: 1),
            .init(title: "Monitor LG 22' 4K 120fps", price: "299,99", amount: 1),
            .init(title: "Erphones for monitor", price: "99,99", amount: 2)
        ]
    }
}
