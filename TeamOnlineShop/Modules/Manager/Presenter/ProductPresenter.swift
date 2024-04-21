//
//  ProductPresenter.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation


protocol ProductPresenterViewProtocol: AnyObject {
    
}

protocol ProductPresenterProtocol: AnyObject {
    var action: ManagerActions.Product { get }
    
    init(router: ProductRouterProtocol, action: ManagerActions.Product)
    func dismissProductVC()
}

final class ProductPresenter: ProductPresenterProtocol {
    weak var view: ProductPresenterViewProtocol?
    var router: ProductRouterProtocol?
    var action: ManagerActions.Product
    var product: Product?
    
    required init(router: ProductRouterProtocol, action: ManagerActions.Product) {
        self.router = router
        self.action = action
    }
    
    func dismissProductVC() {
        router?.dismissProductVC()
    }
}
