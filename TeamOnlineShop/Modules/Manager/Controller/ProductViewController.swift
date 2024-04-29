//
//  ProductViewController.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit
import PlatziFakeStore

final class ProductViewController: UIViewController {
    private let presenter: ProductPresenterProtocol
    private let customView = ProductView()
    
    init(presenter: ProductPresenterProtocol, label: String) {
        self.presenter = presenter
        self.customView.setTitle(label)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomView()
        presenter.loadCategories()
        presenter.loadProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupCustomView() {
        // all current categories array also needed here
        customView.configure(by: presenter.action)
        view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        customView.delegate = self
        customView.setSearchBarDelegate(vc: self)
    }
}

extension ProductViewController: ProductViewDelegate {
    func saveTapped(product: PlatziFakeStore.NewProduct, id: Int?) {
        presenter.saveChanges(newProduct: product, id: id)
    }
    
    func tappedBackButton() {
        presenter.dismissProductVC()
    }
}

extension ProductViewController: ProductPresenterViewProtocol {
    func setProductsForTable(_ products: [Product]) {
        customView.products = products
    }
    
    func setProductsForSelector(_ products: [Product]) {
        customView.setProducts(products)
    }
    
    func setCategories(_ categories: [Category]) {
        customView.setCategories(categories)
    }
    
    func setProduct(_ product: Product) {
        customView.setProduct(product)
    }
    
    func setProducts(_ products: [Product]) {
        customView.products = products
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

extension ProductViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        presenter.searchProducts(query: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
