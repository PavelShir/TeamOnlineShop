import Foundation
import PlatziFakeStore

protocol MainPresenterImplementation: AnyObject {
    func fetchModel()
    func searchAndOpenFilteredResults(query: String)
    func goToProductDetail(_ index: Int)
    func addProductToCart(by id: Int)
    func searchProductsByCategory(_ categoryId: Int)
    func filterByPriceRange(low: Double, high: Double)
    func filterByName()
    func filterByPrice()
    func goToCartVC()
}

final class MainPresenter {
    
    // MARK: - Properties
    weak var view: MainViewImplementation?
    let router: MainRouter
    private var isSortingNamesAscending = true
    private var isSortingPriceAscending = true
    private var categoriesArray = [Category]()
    private var productsArray = [Product]()
    
    init(router: MainRouter) {
        self.router = router
    }
    
    private func getCategoryName(by categoryId: Int) -> String? {
        return categoriesArray.first(where: { $0.id == categoryId })?.name
    }
}

// MARK: - MainPresenter + MainPresenterProtocol
extension MainPresenter: MainPresenterImplementation {
    
    // MARK: - Filter methods
    func filterByPriceRange(low: Double, high: Double) {
        
        productsArray = productsArray.filter { $0.price >= Int(low) && $0.price <= Int(high) }
        DispatchQueue.main.async {
            
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
    
    func filterByName() {

        if isSortingNamesAscending {
            productsArray.sort { $0.title.lowercased() < $1.title.lowercased() }
        } else {
            productsArray.sort { $0.title.lowercased() > $1.title.lowercased() }
        }

        isSortingNamesAscending.toggle()

            DispatchQueue.main.async {
                
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
    
    func filterByPrice() {
        
        if isSortingPriceAscending {
            productsArray.sort { $0.price < $1.price }
        } else {
            productsArray.sort { $0.price > $1.price }
        }
        isSortingPriceAscending.toggle()
        
        DispatchQueue.main.async {
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
    // MARK: - Search methods
    func searchProductsByCategory(_ categoryId: Int) {
        PlatziStore.shared.searchProduct(
            SearchOption.categoryId(categoryId)) { [weak self] result in
            switch result {
            case .success(let products):
                let categoryName = self?.getCategoryName(by: categoryId) ?? "Unknown Category"
                DispatchQueue.main.async {
                    self?.router.showSearch(data: products.map { Product(fromDTO: $0) },
                                            serachText: categoryName)
                }
            case .failure(let error):
                print("Error fetching products by category: \(error)")
            }
        }
    }
    
    func searchAndOpenFilteredResults(query: String) {
        
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("Search query is empty.")
            return
        }
        
        PlatziStore.shared.searchProduct(SearchOption.title(query)) { [weak self] result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.router.showSearch(data: products.map { Product(fromDTO: $0) }, serachText: query)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error during the search: \(error)")
                }
            }
        }
    }
    
    // MARK: - Fetch and init local model
    func fetchModel() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        PlatziStore.shared.categoryList(limit: 7) { [weak self] result in
            defer { dispatchGroup.leave() }
            switch result {
            case .success(let categories):
                self?.categoriesArray = categories.map { Category(fromDTO: $0) }
            case .failure(let error):
                print("Error fetching categories: \(error)")
            }
        }
        
        dispatchGroup.enter()
        PlatziStore.shared.productList(limit: 50, offset: 2) { [weak self] result in
            defer { dispatchGroup.leave() }
            switch result {
            case .success(let products):
                self?.productsArray = products.map { Product(fromDTO: $0) }
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
    
    // MARK: - Navigation methods
    func goToCartVC() {
        router.goToCartVC()
    }
    
    func goToProductDetail(_ index: Int) {
        router.showProductDetail(data: productsArray[index])
    }
    
    func addProductToCart(by id: Int) {
        guard let product = productsArray.first(where: { product in
            product.id == id
        }) else { return }
        
        UserManager.shared.addProductToCart(product: product) { error in
            if error != nil {
                print("Error is occured during adding product to cart")
            }
        }
    }
}
