//
//  CartCollectionDataSource.swift
//  TeamOnlineShop
//
//  Created by Илья Шаповалов on 27.04.2024.
//

import UIKit

final class CartCollectionDataSource: NSObject {
    private let collectionView: UICollectionView
    private var cartItems: [CartItemCell] = .init()
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: CartCell.identifier)
        collectionView.dataSource = self
    }
    
    func update(_ cartItems: [CartItemCell]) {
        self.cartItems = cartItems
        collectionView.reloadData()
    }
}

extension CartCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cartItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCell.identifier, for: indexPath)
        cartItems[safe: indexPath.item].map { item in
                (cell as? CartCell)?.setup(item)
            }
        return cell
    }
}
