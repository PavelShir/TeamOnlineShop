
//  SearchModuleBuilder.swift
//  TeamOnlineShop
//
//  Created by Daniil Murzin on 22.04.2024.
//

import UIKit
import PlatziFakeStore

final class SearchModuleBuilder {
    
    static func build(products: [PlatziFakeStore.Product]) -> SearchViewController {
        
        let presenter  = SearchPresenter()
        let searchViewController = SearchViewController(presenter: presenter, productArray: products)
        presenter.view = searchViewController
        
        return searchViewController
    }
}
