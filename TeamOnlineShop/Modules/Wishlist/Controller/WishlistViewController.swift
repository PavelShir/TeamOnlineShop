//
//  WishlistViewController.swift
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
    private let customView = WishlistView()
    
    init(presenter: WishlistPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        presenter.getWishlistFromUser()
        reload()
    }
    
    private func setupCustomView() {
        customView.setDelegates(self)
    }

}
extension WishlistViewController: UICollectionViewDelegateFlowLayout {}

extension WishlistViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = presenter.getProductsCount()
        customView.switchEmptyLabelVisability(count != 0)
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsViewCell.reuseIdentifier, for: indexPath) as? ProductsViewCell else {
            fatalError("Unable to dequeue ProductsViewCell")
        }
        let product = presenter.getProduct(indexPath.row)
        cell.configure(
            model: product,
           showLikeButton: true)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let spacingBetweenCells: CGFloat = 10
        let totalSpacing = (numberOfColumns - 1) * spacingBetweenCells
        let availableWidth = collectionView.frame.width - totalSpacing
        let widthPerItem = availableWidth / numberOfColumns
        let heightPerItem = widthPerItem * 1.5
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}

extension WishlistViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.goToProductDetail(indexPath.row)
    }
}

extension WishlistViewController: ProductsViewCellDelegate {
    func didTapAddToCartButton(productId id: Int) {
        presenter.addProductToCart(id)
    }
    
    func didTapWishButton(productId id: Int) {
        presenter.deleteProductFromWishList(id)
    }
    
}

//MARK: - WishlistPresenterViewProtocol
extension WishlistViewController: WishlistPresenterViewProtocol {
    
    func reload() {
        customView.reloadCollection()
    }
}

//MARK: - UISearchBarDelegate
extension WishlistViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        presenter.searchProducts(query: searchText)
        searchBar.resignFirstResponder()
    }
}

//MARK: - WishlistViewDelegate
extension WishlistViewController: WishlistViewDelegate {
    func tappedCartButton() {
        presenter.goToCartVC()
    }
}
