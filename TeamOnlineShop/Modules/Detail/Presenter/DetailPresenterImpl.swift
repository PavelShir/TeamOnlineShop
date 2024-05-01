//
//  DetailPresenterImpl.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 25.04.2024.
//

import UIKit


protocol DetailPresenterViewProtocol: AnyObject {
    func updateProductWishState(isWished: Bool)
    func updateCartButtonLabel(with count: Int)
}

protocol DetailPresenter: AnyObject {
    init(router: DetailRouterProtocol,data: Product)
    var data: Product { get }
    func dismissDetailVC()
    func goToCartVC()
    func updateWishList(_ isWished: Bool)
    func viewDidLoad()
    func addProductToCart()
    func buyProductNow()
}

final class DetailPresenterImpl: DetailPresenter {
    
    weak var view: DetailPresenterViewProtocol?
    private var router: DetailRouterProtocol?
    var data: Product
    
    required init(
        router: DetailRouterProtocol,
        data: Product
    ) {
        self.data = data
        self.router = router
    }
    
    func dismissDetailVC(){
        router?.dismissDetailVC()
    }
    
    func goToCartVC(){
        router?.goToCartVC()
    }
    
    func updateWishList(_ isWished: Bool) {
        defer { view?.updateProductWishState(isWished: isWished) }
        
        if isWished {
            UserManager.shared.addProductToWithList(product: data) { error in
                guard let error else { return }
                print("Error is occured during adding product to wishlist")
            }
            return
        }
        UserManager.shared.deleteProductFromWishList(productId: data.id) { error in
            guard let error else { return }
            print("Error is occured during deleting product from wishlist")
        }
    }
    
    func buyProductNow() {
        router?.goToPaymentsVC()
    }
    
    func addProductToCart() {
        UserManager.shared.addProductToCart(product: data) { error in
            if error != nil {
                print("Error is occured during adding product to cart")
            }
        }
        view?.updateCartButtonLabel(with: UserManager.shared.getProductsFromCart().count)
    }
    
    func viewDidLoad() {
        let savedProduts: [Product] = UserManager.shared.getProductsFromWithList()
        let savedProductsIds = savedProduts.map { $0.id }
        
        view?.updateProductWishState(isWished: savedProductsIds.contains(data.id))
        
        view?.updateCartButtonLabel(with: UserManager.shared.getProductsFromCart().count)
    }
}
