import Foundation
import PlatziFakeStore

protocol MainPresenterImplementation: AnyObject {
    func getCategoryArrayCount() -> Int
    func getCategoryData() -> [ProductCategory]
    func fetchModel()
}

final class MainPresenter {
    
    // MARK: - Properties
    weak var view: MainViewImplementation?
    let router: MainRouter
    
    private var categoriesArray = [PlatziFakeStore.Category]()
    private var productsArray = [PlatziFakeStore.Product]()
    
    init(router: MainRouter) {
        self.router = router
    }
}
// MARK: - MainPresenter + MainPresenterProtocol
extension MainPresenter: MainPresenterImplementation {
    
    func getCategoryArrayCount() -> Int {
        MockData.mockItems.count
    }
    
    func getCategoryData() -> [ProductCategory] {
        MockData.mockItems
    }
    
    
    func fetchModel() {
        let dispatchGroup = DispatchGroup()
             
             dispatchGroup.enter()
             PlatziStore.shared.categoryList(limit: 20) { [weak self] result in
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

                                           
