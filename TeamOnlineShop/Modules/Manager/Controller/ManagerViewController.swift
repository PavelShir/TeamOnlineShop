//
//  ManagerViewController.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 20.04.2024.
//

import UIKit

final class ManagerViewController: UIViewController {
    
    var presenter: ManagerPresenterProtocol
    private let customView = ManagerView()
    
    init(presenter: ManagerPresenterProtocol) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
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
}

//MARK: - ManagerViewDelegate
extension ManagerViewController: ManagerViewDelegate {
    func addCategoryTapped(label: String) {
        self.presenter.goToAddCategory(label: label)
    }
    
    func updateCategoryTapped(label: String) {
        self.presenter.goToUpdateCategory(label: label)
    }
    
    func deleteCategoryTapped(label: String) {
        self.presenter.goToDeleteCategory(label: label)
    }
    
    func addProductTapped(label: String) {
        self.presenter.goToAddProduct(label: label)
    }
    
    func updateProductTapped(label: String) {
        self.presenter.goToUpdateProduct(label: label)
    }
    
    func deleteProductTapped(label: String) {
        self.presenter.goToDeleteProduct(label: label)
    }
}

extension ManagerViewController: ManagerPresenterViewProtocol {
    
}
