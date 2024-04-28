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
    func searchAndOpenFilteredResults(query: String)
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
    
    func searchAndOpenFilteredResults(query: String) {
        
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("Search query is empty.")
            return
        }
        
        PlatziStore.shared.searchProduct(SearchOption.title(query)) { [weak self] result in
            switch result {
            case .success(let products):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    let model = SearchModel(
                        productsArray: products,
                        query: query
                    )
                    self.view?.fetchModel(model: model)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error during the search: \(error)")
                }
            }
        }
    }
}
