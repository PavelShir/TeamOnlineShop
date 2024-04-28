//
//  CartViewControllerImpl.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

import UIKit

final class CartViewControllerImpl: UIViewController {
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
        
        delegate.didSelectCartAt = { [weak self] index in
            self?.presenter.didSelectCartItem(at: index)
        }
        delegate.didDeselectCartAt = { [weak self] index in
            self?.presenter.didDeselectCartItem(at: index)
        }
        delegate.selectedItemAd = { [weak self] index in
            self?.presenter.isSelectedItem(at: index) ?? false
        }
        
        cartView.payButton.addAction(
            UIAction { [weak self] _ in self?.presenter.didTapPayButton() },
            for: .touchUpInside
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

//MARK: - CartViewController
extension CartViewControllerImpl: CartViewController {
    func render(_ viewModel: CartViewModel) {
        dataSource.update(viewModel.items)
        cartView.amountLabel.text = viewModel.totalPrice
    }
    
    
}