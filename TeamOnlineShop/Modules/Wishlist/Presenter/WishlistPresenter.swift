//
//  WishlistPresenter.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 25.04.2024.
//

import UIKit


protocol WishlistPresenterViewProtocol: AnyObject {
    func reload()
    func updateCartButtonLabel(with count: Int)
}

protocol WishlistPresenterProtocol: AnyObject {
    init(router: WishlistRouterProtocol)
    func getProductsCount() -> Int
    func getProduct(_ index: Int) -> Product
    func goToProductDetail(_ index: Int)
    func goToCartVC()
    func deleteProductFromWishList(_ id: Int)
    func addProductToCart(_ id: Int)
    func getWishlistFromUser()
    func searchProducts(query: String)
    func viewDidLoad()
}

final class WishlistPresenter: WishlistPresenterProtocol {
    
    weak var view: WishlistPresenterViewProtocol?
    private var router: WishlistRouterProtocol?
    
    var products: [Product] = []
    
    required init(router: WishlistRouterProtocol) {
        self.router = router
    }
    
    func goToCartVC(){
        router?.goToCartVC()
    }
    
    func deleteProductFromWishList(_ id: Int){
        UserManager.shared.deleteProductFromWishList(productId: id){ error in
            if error != nil {
                print("Error is occured during deleting product from wishlist")
            }
        }
        getWishlistFromUser()
        view?.reload()
    }
    
    func addProductToCart(_ id: Int) {
        guard let product = products.first(where: { product in
            product.id == id
        }) else { return }
        
        UserManager.shared.addProductToCart(product: product) { error in
            if error != nil {
                print("Error is occured during adding product to cart")
            }
        }
        
        view?.updateCartButtonLabel(with: UserManager.shared.getProductsFromCart().count)    }
    
    func getProduct(_ index: Int) -> Product {
        return products[index]
    }
    
    func goToProductDetail(_ index: Int) {
        let product = products[index]
        router?.showProductDetail(data: product)
    }
    
    func getWishlistFromUser() {
        products = UserManager.shared.getProductsFromWithList()
    }
    
    func getProductsCount() -> Int {
        return products.count
    }
    
    func searchProducts(query: String) {
        if (query.isEmpty) {
            getWishlistFromUser()
            view?.reload()
            return
        }
        
        products = products.filter{ product in
            product.title.lowercased().contains(query.lowercased())
        }
        view?.reload()
    }
    
    func viewDidLoad() {
        getWishlistFromUser()
        view?.updateCartButtonLabel(with: UserManager.shared.getProductsFromCart().count)
    }
}
