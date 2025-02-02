//
//  DetailViewController.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 25.04.2024.
//

import UIKit

protocol DetailVCDelegate{
    func updateWishButtonState(isWished: Bool)
    func updateCartButtonLabel(with count: Int)
}

final class DetailViewController: UIViewController {

    private let presenter: DetailPresenterProtocol
    var detailView: DetailVCDelegate?
    private let customView = DetailView()
    
    init(presenter: DetailPresenterProtocol) {
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
        self.tabBarController?.tabBar.isHidden = true
        presenter.viewDidLoad()
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
        customView.setDelegates(self)
    }
    
    private func configView() {
        customView.configView(data: presenter.data , isLiked: false)
    }

}

//MARK: - DetailViewDelegate
extension DetailViewController: DetailViewDelegate {    
    
    func tappedBackButton() {
        presenter.dismissDetailVC()
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
    
    func tappedBuyNowButton() {
        presenter.buyProductNow()
    }
}

//MARK: - DetailPresenterViewProtocol
extension DetailViewController: DetailPresenterViewProtocol {
    func updateProductWishState(isWished: Bool) {
        customView.updateWishButtonState(isWished: isWished)
    }
    
    func updateCartButtonLabel(with count: Int) {
        customView.updateCartButtonLabel(with: count)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.data.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Unable to dequeue ImageCollectionViewCell")
        }
        cell.configure(with: presenter.data.images[indexPath.item])
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {}

