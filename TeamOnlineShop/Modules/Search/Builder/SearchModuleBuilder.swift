
//  SearchModuleBuilder.swift
//  TeamOnlineShop
//
//  Created by Daniil Murzin on 22.04.2024.
//

import UIKit
import PlatziFakeStore

final class SearchModuleBuilder {
    
    static func build(
        router: MainRouter,
        products: [PlatziFakeStore.Product],
        searchText: String) -> SearchViewController {
        
            let presenter  = SearchPresenter(router: router, productsArray: products)
            let searchViewController = SearchViewController(
                presenter: presenter,
                productArray: products,
                searchText: searchText)
            
            presenter.view = searchViewController
            
            return searchViewController
        }
}

