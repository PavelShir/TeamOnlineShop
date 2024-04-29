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
    func setProduct(_ product: Product)
    func setProducts(_ products: [Product])
    func setProductsForTable(_ products: [Product])
    func setProductsForSelector(_ products: [Product])
}

protocol ProductPresenterProtocol: AnyObject {
    var action: ManagerActions.Product { get }
    
    init(router: ProductRouterProtocol, action: ManagerActions.Product)
    func dismissProductVC()
    func saveChanges(newProduct: PlatziFakeStore.NewProduct, id: Int?)
    func searchProducts(query: String)
    func loadCategories()
    func getCategories() -> [Category]
    func loadProducts()
}

final class ProductPresenter: ProductPresenterProtocol {
    weak var view: ProductPresenterViewProtocol?
    var router: ProductRouterProtocol?
    var action: ManagerActions.Product
    var product: PlatziFakeStore.Product?
    var products: [Product] = .init()
    private var categoriesArray = [Category]()
    
    required init(router: ProductRouterProtocol, action: ManagerActions.Product) {
        self.router = router
        self.action = action
    }
    
    func dismissProductVC() {
        router?.dismissProductVC()
    }
    
    func saveChanges(newProduct: PlatziFakeStore.NewProduct, id: Int?) {
        
        switch self.action {
        case .add:
            PlatziStore.shared.create(product: newProduct) { [weak self] result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self?.view?.showAlert(title: "Success", message: "Succesfully add new product")
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.view?.showAlert(title: "Error", message: "Error during adding product: \(error)")
                    }
                }
            }
            return
        case .update:
            if let productId = id {
                PlatziStore.shared.updateProduct(withId: productId, new: newProduct) { [weak self] result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self?.view?.showAlert(title: "Success", message: "Succesfully update product")
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.view?.showAlert(title: "Error", message: "Error during updating product: \(error)")
                        }
                    }
                }
            }
            return
        case .delete:
            if let productId = id {
                PlatziStore.shared.deleteProduct(withId: productId){ [weak self] result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self?.view?.showAlert(title: "Success", message: "Succesfully remove product")
                            let pros = self?.products.filter{ $0.id != productId }
                            self?.view?.setProducts(pros ?? [])
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.view?.showAlert(title: "Error", message: "Error during removing product: \(error)")
                        }
                    }
                }
            }
            return
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
    func loadProducts() {
        PlatziStore.shared.productList(limit: 40) { [weak self] result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    let pros = products.map { Product(fromDTO: $0) }
                    self?.products = pros
                    if self?.action == .update {
                        self?.view?.setProductsForSelector(pros)
                    } else if self?.action == .delete {
                        
                        self?.view?.setProductsForTable(pros)
                    }
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
        PlatziStore.shared.searchProduct(SearchOption.title(query)) { [weak self] result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    if self?.action == .update {
                        if let product = products.first {
                            self?.product = product
                            self?.view?.setProduct(Product(fromDTO: product))
                        }
                    } else if self?.action == .delete {
                        let pros = products.map { Product(fromDTO: $0) }
                        self?.products = pros
                        self?.view?.setProducts(pros)
                    }
                    
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error during the search: \(error)")
                }
            }
        }
    }
}
