//
//  CategoryViewController.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

final class CategoryViewController: UIViewController {
    private let presenter: CategoryPresenterProtocol
    private let customView = CategoryView()
    
    init(presenter: CategoryPresenterProtocol, label: String) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupCustomView() {
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

extension CategoryViewController: CategoryViewDelegate {
    func saveTapped(category: Category) {
        presenter.saveChanges(category: category)
    }
    
    func tappedBackButton() {
        presenter.dismissCategoryVC()
    }
}

extension CategoryViewController: CategoryPresenterViewProtocol {
    
}

extension CategoryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        presenter.searchCategories(query: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
