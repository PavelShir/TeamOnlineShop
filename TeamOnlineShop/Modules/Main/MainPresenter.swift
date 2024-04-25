import Foundation
import PlatziFakeStore

protocol MainPresenterImplementation: AnyObject {
    func fetchModel()
    func searchAndOpenFilteredResults(query: String)
}

final class MainPresenter {
    
    // MARK: - Properties
    weak var view: MainViewImplementation?
    let router: MainRouter
    
    private var categoriesArray = [PlatziFakeStore.Category]()
    private var productsArray = [PlatziFakeStore.Product]()
    private var filteredProducts = [PlatziFakeStore.Product]()
    
    init(router: MainRouter) {
        self.router = router
    }
    
    private func fetchProducts(completion: @escaping () -> Void) {
        PlatziStore.shared.productList(limit: 40, offset: 0) { [weak self] result in
            switch result {
            case .success(let products):
                self?.filteredProducts = products
                completion()
            case .failure(let error):
                print("Error fetching products: \(error)")
            }
        }
    }
}

// MARK: - MainPresenter + MainPresenterProtocol
extension MainPresenter: MainPresenterImplementation {
    
    func searchAndOpenFilteredResults(query: String) {
        
        fetchProducts { [weak self] in
            guard let self = self else { return }
            
            let filteredProducts = self.filteredProducts.filter { $0.title.lowercased().contains(query.lowercased()) }
            
            print("Filtered products: \(filteredProducts.map { $0.title })")
            if !filteredProducts.isEmpty {
                
                DispatchQueue.main.async {
                    self.router.showSearch(data: filteredProducts)
                }
                
            } else {
                print("No products found matching the query.")
            }
        }
    }
    
    
    func fetchModel() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        PlatziStore.shared.categoryList(limit: 7) { [weak self] result in
            defer { dispatchGroup.leave() }
            switch result {
            case .success(let categories):
                self?.categoriesArray = categories
            case .failure(let error):
                print("Error fetching categories: \(error)")
            }
        }
        
        dispatchGroup.enter()
        PlatziStore.shared.productList(limit: 20, offset: 0) { [weak self] result in
            defer { dispatchGroup.leave() }
            switch result {
            case .success(let products):
                self?.productsArray = products
            case .failure(let error):
                print("Error fetching products: \(error)")
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            let model = Model(
                isExpanded: false,
                productCategory: self.categoriesArray,
                productsArray: self.productsArray,
                query: "Search",
                address: "Delivery address"
            )
            self.view?.render(model: model)
        }
    }
}


