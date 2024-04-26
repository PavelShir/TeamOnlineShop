//
//  DetailViewController.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 25.04.2024.
//

import UIKit

protocol WishlistVCDelegate{
    func updateWishButtonState(isWished: Bool)
}

final class WishlistViewController: UIViewController {

    private let presenter: WishlistPresenterProtocol
    var detailView: WishlistVCDelegate?
    private let customView = WishlistView()
    
    init(presenter: WishlistPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomView()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
        presenter.setProductWishState()
    }
    
    private func setupCustomView() {
        view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        customView.delegate = self
    }
    
    private func configView() {
//        customView.configView(data: presenter.data , isLiked: false)
    }

}

//MARK: - WishlistViewDelegate
extension WishlistViewController: WishlistViewDelegate {
    
    func tappedBackButton() {
        presenter.goToDetailVC()
    }
    
    func tappedCartButton() {
        presenter.goToCartVC()
    }
    
    func tappedWishButton(_ isWished: Bool) {
        presenter.updateWishList(isWished)
    }
    
    func tappedAddToCartButton() {
        presenter.addProductToCart()
    }
}

//MARK: - WishlistPresenterViewProtocol
extension WishlistViewController: WishlistPresenterViewProtocol {
    func updateProductWishState(isWished: Bool) {
        customView.updateWishButtonState(isWished: isWished)
    }
}

