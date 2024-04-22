//
//  ManagerPresenter.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 20.04.2024.
//

import UIKit

enum ManagerActions {
    enum Category {
        case add
        case update
        case delete
    }
    
    enum Product {
        case add
        case update
        case delete
    }
}

protocol ManagerPresenterViewProtocol: AnyObject {
    
}

protocol ManagerPresenterProtocol: AnyObject {
    
    init(router: ManagerRouterProtocol)
    
    func goToAddCategory(label: String)
    func goToUpdateCategory(label: String)
    func goToDeleteCategory(label: String)
    
    func goToAddProduct(label: String)
    func goToUpdateProduct(label: String)
    func goToDeleteProduct(label: String)
    
}


final class ManagerPresenter: ManagerPresenterProtocol {
    weak var view: ManagerPresenterViewProtocol?
    var router: ManagerRouterProtocol?
    
    required init(router: ManagerRouterProtocol
    ) {
        self.router = router
    }
    
    func goToAddCategory(label: String) {
        router?.pushToCategory(label: label, action: ManagerActions.Category.add)
    }
    
    func goToUpdateCategory(label: String) {
        router?.pushToCategory(label: label, action: ManagerActions.Category.update)
    }
    
    func goToDeleteCategory(label: String) {
        router?.pushToCategory(label: label, action: ManagerActions.Category.delete)
    }
    
    func goToAddProduct(label: String) {
        router?.pushToProduct(label: label, action: ManagerActions.Product.add)
    }
    
    func goToUpdateProduct(label: String) {
        router?.pushToProduct(label: label, action: ManagerActions.Product.update)
    }
    
    func goToDeleteProduct(label: String) {
        router?.pushToProduct(label: label, action: ManagerActions.Product.delete)
    }
}
