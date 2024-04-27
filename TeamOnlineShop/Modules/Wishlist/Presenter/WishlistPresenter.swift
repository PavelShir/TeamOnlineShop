//
//  WishlistPresenter.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 25.04.2024.
//

import UIKit


protocol WishlistPresenterViewProtocol: AnyObject {
    func reload()
}

protocol WishlistPresenterProtocol: AnyObject {
    init(router: WishlistRouterProtocol)
    func getProductsCount() -> Int
    func goToProductDetail(_ index: Int)
    func goToCartVC()
    func deleteProductFromWishList(_ index: Int)
    func addProductToCart(_ index: Int)
    func getWishlistFromUser()
    func searchProducts(query: String)
}

final class WishlistPresenter: WishlistPresenterProtocol {
    
    private weak var view: WishlistPresenterViewProtocol?
    private var router: WishlistRouterProtocol?
    
    var products: [Product] = []
    
    required init(router: WishlistRouterProtocol) {
        self.router = router
    }
    
    func goToCartVC(){
        router?.goToCartVC()
    }
    
    func deleteProductFromWishList(_ index: Int){
//        UserManager.shared.deleteProductFromWishList(productId: <#T##Int#>, completion: <#T##((any Error)?) -> Void#>)
        getWishlistFromUser()
    }
    
    func addProductToCart(_ index: Int) {
//        UserManager.shared.addProductToCart(product: data) { error in
//            print("complete")
//        }
    }
    
    func goToProductDetail(_ index: Int) {
        let product = products[index]
        router?.showProductDetail(data: product)
    }
    
    func getWishlistFromUser() {
        // products = get wishlist from user
    }
    
    func getProductsCount() -> Int {
        return products.count
    }
    
    func searchProducts(query: String) {
        if (query.isEmpty) {
            getWishlistFromUser()
            return
        }
        
        products = products.filter{ product in
            product.title.lowercased().contains(query.lowercased())
        }
        view?.reload()
    }
}
