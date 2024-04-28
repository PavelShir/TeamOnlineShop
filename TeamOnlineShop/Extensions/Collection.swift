//
//  Collection.swift
//  TeamOnlineShop
//
//  Created by Илья Шаповалов on 27.04.2024.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        self.indices.contains(index) ? self[index] : nil
    }
}
