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
    
    private lazy var badgeCount: UILabel = {
        let element = UILabel(frame: CGRect(x: 22, y: -03, width: 14, height: 14))
        element.layer.borderColor = UIColor.clear.cgColor
        element.layer.borderWidth = 2
        element.layer.cornerRadius = element.bounds.size.height / 2
        element.textAlignment = .center
        element.layer.masksToBounds = true
        element.textColor = .white
        element.font = UIFont.TextFont.Element.TabBar.label
        element.backgroundColor = .redLight
        element.text = "3"
        return element
    }()

    private lazy var cartButton: UIButton = {
        let element = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
        element.setBackgroundImage(UIImage(systemName: "cart"), for: .normal)
        element.tintColor = .black
//        element.addTarget(self, action: #selector(self.onBtnNotification), for: .touchUpInside)
        element.addSubview(badgeCount)
        return element
    }()

    private lazy var cartButtonWithBadge: UIBarButtonItem = {
        let element = UIBarButtonItem(customView: cartButton)
        return element
    }()
    
    private func setNavigationBar() {
        title = "Your Cart"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = cartButtonWithBadge

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
