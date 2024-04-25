//
//  CollectionHeaderView.swift
//  TeamOnlineShop
//
//  Created by Daniil Murzin on 23.04.2024.
//

import UIKit

final class CollectionHeaderView: UICollectionReusableView {
   
    // MARK: - Properties
    static let reuseIdentifier = ProductsViewCell.description()
    
    private let searchBarView: SearchBarView = {
        let view = SearchBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let filterButton: CustomFiltersButton = {
        let button = CustomFiltersButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let view = UICollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchResultsLabel: UILabel = {
        let element = UILabel()
        element.text = "Search results for 'Earphone' "
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(collectionView, searchBarView,filterButton,collectionView)
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: topAnchor),
            searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8),
            searchBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            filterButton.topAnchor.constraint(equalTo: topAnchor),
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            filterButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
}
