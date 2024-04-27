//
//  CartCollectionDelegate.swift
//  TeamOnlineShop
//
//  Created by Илья Шаповалов on 27.04.2024.
//

import UIKit

final class CartCollectionDelegate: NSObject {
    private let collectionView: UICollectionView
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.delegate = self
    }
}

extension CartCollectionDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height / 6
        )
    }
}

