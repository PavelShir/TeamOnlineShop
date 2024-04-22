import Foundation

protocol MainPresenterImplementation: AnyObject {
    func getCategoryArrayCount() -> Int
    func getCategoryData() -> [ProductCategory]
    func fetchModel()
}

final class MainPresenter {
    
    // MARK: - Properties
    weak var view: MainViewImplementation?
    let router: MainRouter
    
    var categoriesArray = [ProductCategory]()
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
          
           let model = Model(
               isExpanded: false,
               productCategory: MockData.mockItems,
               productsArray: MockData.mockProducts,
               query: "Search",
               address: "Delivery address"
           )
           view?.render(model: model)
       }
}
