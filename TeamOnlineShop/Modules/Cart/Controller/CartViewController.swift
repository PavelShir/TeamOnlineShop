//
//  CartViewController.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

import UIKit

protocol CartVCDelegate {}

final class CartViewController: UIViewController {
    
    private let presenter: CartPresenterProtocol
    var cartView: CartVCDelegate?
    private let customView = CartView()
    
    init(presenter: CartPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemCart: [CartItem] = Cart.allItems()
    
    //MARK: - UI Collection View
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 350, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: "CartCell")
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isUserInteractionEnabled = false
        return collectionView
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Set Views
    
    private func setViews() {
        view.backgroundColor = .white
        view.addSubview(customView)
        view.addSubview(collectionView)
    }
    
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.bottomAnchor,constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -160),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    private func configView() {
//        customView.configView(data: presenter.data , isLiked: false)
    }
}

//MARK: - CartViewDelegate

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

//MARK: - CartViewDelegate

extension CartViewController: CartViewDelegate {
    func tappedBackButton() {
        presenter.dismissCartVC()
    }
    
    func tappedCartButton() {
        
    }
    
    func tappedBuyButton() {
        let payVC = PaymentsViewController()
        present(payVC, animated: true)
    }
}
