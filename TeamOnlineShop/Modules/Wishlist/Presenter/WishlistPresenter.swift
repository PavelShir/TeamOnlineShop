//
//  WishlistPresenter.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 25.04.2024.
//

import UIKit


protocol WishlistPresenterViewProtocol: AnyObject {
    func updateProductWishState(isWished: Bool)
    
}

protocol WishlistPresenterProtocol: AnyObject {
    init(router: WishlistRouterProtocol)
    func goToDetailVC()
    func goToCartVC()
    func updateWishList(_ isWished: Bool)
    func setProductWishState()
    func addProductToCart()
}

final class WishlistPresenter: WishlistPresenterProtocol {
    
    private weak var view: WishlistPresenterViewProtocol?
    private var router: WishlistRouterProtocol?
    
    required init(router: WishlistRouterProtocol) {
        self.router = router
    }
    
    func goToDetailVC(){
        router?.goToDetailVC()
    }
    
    func goToCartVC(){
        router?.goToCartVC()
    }
    
    func updateWishList(_ isWished: Bool){
        if isWished {
           print("")
        } else {
            print("")
        }
        view?.updateProductWishState(isWished: !isWished)
    }
    
    func addProductToCart() {
//        UserManager.shared.addProductToCart(product: data) { error in
            print("complete")
//        }
    }
    
    func setProductWishState() {
        let savedProduts: [Product] = UserManager.shared.getProductsFromWithList()
        let savedProductsIds = savedProduts.map { $0.id }
        
//        view?.updateProductWishState(isWished: savedProductsIds.contains(data.id))
    }
}
