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
    func addProductToCart(by id: Int)
    func searchAndOpenFilteredResults(query: String)
}

final class SearchPresenter {
    
    weak var view: SearchViewImplementation?
    let router: MainRouter
    private var productsArray = [Product]()
    
    init(router: MainRouter,
         productsArray: [Product]) {
        self.router = router
        self.productsArray = productsArray
    }
}

extension SearchPresenter: SearchPresenterImplementation {
    func goToProductDetail(_ index: Int) {
        router.showProductDetail(data: productsArray[index])
    }
    
    func addProductToCart(by id: Int) {
        guard let product = productsArray.first(where: { product in
            product.id == id
        }) else { return }
        
        UserManager.shared.addProductToCart(product: product) { error in
            print("complete")
        }
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
                        productsArray: products.map { Product(fromDTO: $0) },
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
