//
//  CartPresenter.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 26.04.2024.
//

import UIKit

protocol CartPresenterViewProtocol: AnyObject {
    
}

protocol CartPresenterProtocol: AnyObject {
    init(router: CartRouterProtocol, data: Cart)
    var data: Cart { get }
    func dismissCartVC()
    func goToPaymentsVC()
    
}

final class CartPresenter: CartPresenterProtocol {

    private weak var view: CartPresenterViewProtocol?
    private var router: CartRouterProtocol?
    var data: Cart
    
    required init(router: CartRouterProtocol, data: Cart) {
        self.data = data
        self.router = router
    }
    
    func dismissCartVC() {
        router?.dismissCartVC()
    }
    
    func goToPaymentsVC() {
        router?.goToPaymentsVC()
    }
    
    
}
