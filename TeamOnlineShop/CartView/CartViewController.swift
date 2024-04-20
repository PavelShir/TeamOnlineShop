//
//  CartViewController.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

import UIKit

class CartViewController: UIViewController {
    
    let itemCart: [CartModel] = Cart.allItems()
    
    //MARK: - Set Navigation Bar
    
    private lazy var backButton: UIBarButtonItem = {
        let element = UIBarButtonItem()
        element.image = .Icons.arrowLeft
        element.tintColor = .blackLight
//        element.action = #selector(backButtonTapped)
        element.target = self
        return element
    }()
    
    private lazy var cartButton: UIBarButtonItem = {
        let element = UIBarButtonItem()
        element.image = .Icons.cart
        element.tintColor = .blackLight
//        element.action = #selector(cartButtonTapped)
        return element
    }()
    
    private lazy var countCart: UILabel = {
        let element = UILabel()

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private func setNavigationBar() {
        title = "Your Cart"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = cartButton

    }
    
    //MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 350, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: "CartCell")
        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
//        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = false
        return collectionView
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setViews()
        setupConstraints()
    }
    
    //MARK: - Set Views
    
    private func setViews() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
    }
    
}

//MARK: - Setup Constraints

extension CartViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
}

//MARK: - Delegate

extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(itemCart.count)
        return itemCart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.setup(Cart.allItems()[indexPath.item])
        return cell
    }
    
    
}
