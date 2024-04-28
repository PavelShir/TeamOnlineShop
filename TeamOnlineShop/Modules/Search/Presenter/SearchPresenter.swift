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
    func filterByPriceRange(low: Double, high: Double)
    func filterByName()
    func filterByPrice()
}

final class SearchPresenter {
    
    // MARK: - Properies
    weak var view: SearchViewImplementation?
    let router: MainRouter
    private var query = " "
    var isSortingAscending = true
    var isSortingPriceAscending = true
    private var productsArray = [Product]()
   
    // MARK: - Init
    init(router: MainRouter,
         productsArray: [Product]) {
        self.router = router
        self.productsArray = productsArray
    }
}
// MARK: - SearchPresenter + SearchPresenterImplementation
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
        
        view?.updateCartLabelCount(count: UserManager.shared.getProductsFromCart().count)
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
                self.query = query
                DispatchQueue.main.async {
                    let model = SearchModel(
                        productsArray: products.map { Product(fromDTO: $0) },
                        query: query
                    )
                    self.view?.fetchModel(model: model)
                    
                    self.view?.updateCartLabelCount(count: UserManager.shared.getProductsFromCart().count)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error during the search: \(error)")
                }
            }
        }
    }
    
    func filterByName() {
        
        if isSortingAscending {
            productsArray.sort { $0.title.lowercased() < $1.title.lowercased() }
        } else {
            productsArray.sort { $0.title.lowercased() > $1.title.lowercased() }
        }
        
        isSortingAscending.toggle()
        DispatchQueue.main.async {
            
            let model = SearchModel(
                productsArray: self.productsArray,
                query: self.query
            )
            self.view?.fetchModel(model: model)
            
            self.view?.updateCartLabelCount(count: UserManager.shared.getProductsFromCart().count)
        }
    }
    
    func filterByPriceRange(low: Double, high: Double) {
        
        productsArray = productsArray.filter { $0.price >= Int(low) && $0.price <= Int(high) }
        DispatchQueue.main.async {
            
            let model = SearchModel(
                productsArray: self.productsArray,
                query: self.query
            )
            self.view?.fetchModel(model: model)
            
            self.view?.updateCartLabelCount(count: UserManager.shared.getProductsFromCart().count)
        }
    }
    
    func filterByPrice() {
            
            if isSortingPriceAscending {
                productsArray.sort { $0.price < $1.price }
            } else {
                productsArray.sort { $0.price > $1.price }
            }
            
            isSortingPriceAscending.toggle()
            
            DispatchQueue.main.async {
                let model = SearchModel(
                    productsArray: self.productsArray,
                    query: self.query
                )
                self.view?.fetchModel(model: model) 
                
                self.view?.updateCartLabelCount(count: UserManager.shared.getProductsFromCart().count)
        }
    }
}
