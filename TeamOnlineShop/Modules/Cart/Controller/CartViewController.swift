//
//  CartViewController.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

import UIKit

protocol CartVCDelegate {}

final class CartViewController: UIViewController {
    //MARK: - Private properties
    private let presenter: CartPresenterProtocol
    private let cartView: CartView
    
    private let dataSource: CartCollectionDataSource
    private let delegate: CartCollectionDelegate
    
    //MARK: - init(_:)
    init(
        presenter: CartPresenterProtocol,
        cartView: CartView
    ) {
        self.presenter = presenter
        self.cartView = cartView
        self.dataSource = CartCollectionDataSource(cartView.collectionView)
        self.delegate = CartCollectionDelegate(cartView.collectionView)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.update(Cart.allItems())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
