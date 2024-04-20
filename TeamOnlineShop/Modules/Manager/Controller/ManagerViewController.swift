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
    func addCategoryTapped() {
        print("add cat")
    }
    
    func updateCategoryTapped() {
        print("upd cat")
        
    }
    
    func deleteCategoryTapped() {
        print("del cat")
        
    }
    
    func addProductTapped() {
        print("add pro")
        
    }
    
    func updateProductTapped() {
        print("upd pro")
        
    }
    
    func deleteProductTapped() {
        print("del pro")
        
    }
}

extension ManagerViewController: ManagerPresenterViewProtocol {
    
}
