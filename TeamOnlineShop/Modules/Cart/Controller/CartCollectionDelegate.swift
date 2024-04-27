//
//  CartCollectionDelegate.swift
//  TeamOnlineShop
//
//  Created by Илья Шаповалов on 27.04.2024.
//

import UIKit

final class CartCollectionDelegate: NSObject {
    private let collectionView: UICollectionView
    
    var didSelectCartAt: ((Int) -> Void)?
    var didDeselectCartAt: ((Int) -> Void)?
    var selectedItemAd: ((Int) -> Bool)?
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.delegate = self
    }
}

extension CartCollectionDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        didSelectCartAt?(indexPath.item)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        didDeselectCartAt?(indexPath.item)
    }
    
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard selectedItemAd?(indexPath.item) == true else { return }
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        cell.isSelected = true
    }
}

