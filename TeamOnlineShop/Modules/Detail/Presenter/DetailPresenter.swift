//
//  DetailPresenter.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 25.04.2024.
//

import UIKit


protocol DetailPresenterViewProtocol: AnyObject {
    func updateProductWishState(isWished: Bool)
    func updateCartButtonLabel(with count: Int)
}

protocol DetailPresenterProtocol: AnyObject {
    init(router: DetailRouterProtocol,data: Product)
    var data: Product { get }
    func dismissDetailVC()
    func goToCartVC()
    func updateWishList(_ isWished: Bool)
    func viewDidLoad()
    func addProductToCart()
    func buyProductNow()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailPresenterViewProtocol?
    private var router: DetailRouterProtocol?
    var data: Product
    
    required init(router: DetailRouterProtocol, data: Product) {
        self.data = data
        self.router = router
    }
    
    func dismissDetailVC(){
        router?.dismissDetailVC()
    }
    
    func goToCartVC(){
        router?.goToCartVC()
    }
    
    func updateWishList(_ isWished: Bool){
        if isWished {
            UserManager.shared.addProductToWithList(product: data) { error in
                print("complete")
            }
        } else {
            UserManager.shared.deleteProductFromWishList(productId: data.id) { error in
                print("complete")
            }
        }
        view?.updateProductWishState(isWished: isWished)
    }
    
    func buyProductNow() {
        router?.goToPaymentsVC()
    }
    
    func addProductToCart() {
        UserManager.shared.addProductToCart(product: data) { error in
            print("complete")
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
