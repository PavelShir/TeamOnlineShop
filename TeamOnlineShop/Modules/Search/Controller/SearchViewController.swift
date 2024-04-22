//
//  SearchViewController.swift
//  TeamOnlineShop
//
//  Created by Daniil Murzin on 22.04.2024.
//

import UIKit

protocol SearchViewImplementation: AnyObject {}

final class SearchViewController: UIViewController {
    
    // MARK: - properties
    
    private let presenter: SearchPresenterImplementation
    
    var productArray = [Product]()
    
    init(presenter: SearchPresenterImplementation, productArray: [Product]) {
        self.presenter = presenter
        self.productArray = productArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        dataSource.updateContent([])
//        presenter.fetchModel()
    }
    
}

extension SearchViewController: SearchViewImplementation {}

