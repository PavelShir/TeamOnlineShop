//
//  WishlistView.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 25.04.2024.
//

import UIKit
import AsyncImageView

protocol WishlistViewDelegate: AnyObject {
    func tappedCartButton()
}

final class WishlistView: UIView {
    weak var delegate: WishlistViewDelegate?
    private let searchBar = CustomSearchBarView()
    
    private let emptyWishlistLabel: UILabel = {
        let label = UILabel()
        label.text = "You don't add anything to wishlist"
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.TextFont.Screens.text
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setBackgroundImage(UIImage.Icons.cart, for: .normal)
        button.tintColor = UIColor(named: Colors.blackLight)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var hStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fill
        element.alignment = .center
        element.spacing = 15
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    private let separator = Separator()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductsViewCell.self, forCellWithReuseIdentifier: ProductsViewCell.reuseIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        layoutViews()
    }
    
    func setDelegates(_ value: WishlistViewController) {
        delegate = value
        collectionView.dataSource = value
        collectionView.delegate = value
        searchBar.delegate = value
    }
    
    func setViews() {
        self.backgroundColor = UIColor(named: Colors.whitePrimary)
        
        [searchBar, cartButton].forEach { hStack.addArrangedSubview($0) }
        [
            hStack,
            separator,
            collectionView,
            emptyWishlistLabel,
        ].forEach { addSubview($0) }
        
        cartButton.addTarget(nil, action: #selector(cartTapped), for: .touchUpInside)
    }
    
    func switchEmptyLabelVisability(_ isHidden: Bool) {
        if searchBar.text?.count != 0 && !isHidden {
            emptyWishlistLabel.text = "No matches"
        } else {
            emptyWishlistLabel.text = "You don't add anything to wishlist"
        }
        emptyWishlistLabel.isHidden = isHidden
    }
    
    @objc private func cartTapped(){
        delegate?.tappedCartButton()
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            hStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            cartButton.widthAnchor.constraint(equalToConstant: 25),
            cartButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            separator.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            emptyWishlistLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyWishlistLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyWishlistLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emptyWishlistLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
}
