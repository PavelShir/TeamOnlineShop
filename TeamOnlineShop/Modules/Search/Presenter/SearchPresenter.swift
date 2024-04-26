//
//  SearchPresenter.swift
//  TeamOnlineShop
//
//  Created by Daniil Murzin on 22.04.2024.
//

import Foundation
import PlatziFakeStore

protocol SearchPresenterImplementation {
    func goToProductDetail(_ index: Int)
    
}

final class SearchPresenter {
    
    weak var view: SearchViewImplementation?
    let router: MainRouter
    private var productsArray = [PlatziFakeStore.Product]()
    
    init(router: MainRouter,
         productsArray: [PlatziFakeStore.Product]) {
        self.router = router
        self.productsArray = productsArray
    }
}

extension SearchPresenter: SearchPresenterImplementation {
    func goToProductDetail(_ index: Int) {
        let product = productsArray[index]
        let convertedProduct = Product(
            id: product.id,
            title: product.title,
            price: product.price,
            description: product.description,
            images: product.images,
            category: Category(id: product.category.id, name: product.category.name, image: product.category.image),
            categoryId: product.category.id
        )
        router.showProductDetail(data: convertedProduct)
    }
}
