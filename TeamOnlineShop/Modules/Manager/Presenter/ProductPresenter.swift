//
//  ProductPresenter.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation
import PlatziFakeStore

protocol ProductPresenterViewProtocol: AnyObject {
    func setCategories(_ categories: [Category])
    func showAlert(title: String, message: String)
}

protocol ProductPresenterProtocol: AnyObject {
    var action: ManagerActions.Product { get }
    
    init(router: ProductRouterProtocol, action: ManagerActions.Product)
    func dismissProductVC()
    func saveChanges(newProduct: PlatziFakeStore.NewProduct)
    func searchProducts(query: String)
    func loadCategories()
    func getCategories() -> [Category]
}

final class ProductPresenter: ProductPresenterProtocol {
    weak var view: ProductPresenterViewProtocol?
    var router: ProductRouterProtocol?
    var action: ManagerActions.Product
    var product: PlatziFakeStore.Product?
    private var categoriesArray = [Category]()
    
    required init(router: ProductRouterProtocol, action: ManagerActions.Product) {
        self.router = router
        self.action = action
    }
    
    func dismissProductVC() {
        router?.dismissProductVC()
    }
    
    func saveChanges(newProduct: PlatziFakeStore.NewProduct) {
           if let productId = product?.id {
               PlatziStore.shared.updateProduct(withId: productId, new: newProduct) { [weak self] result in
                   switch result {
                   case .success(let product):
                       DispatchQueue.main.async {
                           self?.view?.showAlert(title: "Success", message: "Succesfully update product")
                       }
                   case .failure(let error):
                       DispatchQueue.main.async {
                           self?.view?.showAlert(title: "Error", message: "Error during updating product: \(error)")
                       }
                   }
               }
           } else {
               PlatziStore.shared.create(product: newProduct) { [weak self] result in
                   switch result {
                   case .success(let product):
                       DispatchQueue.main.async {
                           self?.view?.showAlert(title: "Success", message: "Succesfully add new product")
                       }
                   case .failure(let error):
                       DispatchQueue.main.async {
                           self?.view?.showAlert(title: "Error", message: "Error during adding product: \(error)")
                       }
                   }
               }
           }
    }
    
    func loadCategories() {
        PlatziStore.shared.categoryList(limit: 20) { [weak self] result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    let cats = categories.map { Category(fromDTO: $0) }
                    self?.categoriesArray = cats
                    self?.view?.setCategories(cats)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error fetching categories: \(error)")
                }
            }
        }
    }
    
    func getCategories() -> [Category] {
        return categoriesArray
    }
    
    func searchProducts(query: String) {
        // call here network method with query to find products
        // after set products to view base on action
        // if update - get first element from array
        // if delete - all found elements
    }
}
