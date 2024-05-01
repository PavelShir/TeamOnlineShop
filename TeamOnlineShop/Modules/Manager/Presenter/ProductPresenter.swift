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
        performChanges(newProduct: newProduct, id: id) { [weak self] action in
            DispatchQueue.main.async {
                switch action {
                case .add(.success(let product)):
                    self?.view?.showAlert(title: "Success", message: "Succesfully add new product")
                    
                case .update(.success(let product)):
                    self?.view?.showAlert(title: "Success", message: "Succesfully update product")
                    
                case .delete(.success(let deleted)):
                    self?.view?.showAlert(title: "Success", message: "Succesfully remove product")
                    
                    let pros = self?.products.filter{ $0.id != id }
                    self?.view?.setProducts(pros ?? [])
                    
                default:
                    self?.view?.showAlert(title: "Error", message: "Error during adding product")
                }
            }
        }
    }
    
    enum ProductAction {
        case add(Result<PlatziFakeStore.Product, StoreError>)
        case update(Result<PlatziFakeStore.Product, StoreError>)
        case delete(Result<Bool, StoreError>)
    }
    
    private func performChanges(
        newProduct: PlatziFakeStore.NewProduct,
        id: Int?,
        completion: @escaping (ProductAction) -> Void
    ) {
        switch self.action {
        case .add:
            PlatziStore.shared.create(product: newProduct) { result in
                completion(.add(result))
            }
            
        case .update:
            guard let id else { return }
            PlatziStore.shared.updateProduct(withId: id, new: newProduct) { result in
                completion(.update(result))
            }
            
        case .delete:
            guard let id else { return }
            PlatziStore.shared.deleteProduct(withId: id){ result in
                completion(.delete(result))
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
        PlatziStore.shared.searchProduct(.title(query)) { [weak self] result in
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
