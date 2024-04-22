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
//    private let platziFakeStore: PlatziFakeStore
    
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
//
//func fetchModel() {
//    platziFakeStore.productList { result in
//        switch result {
//        case .success(let products):
//
//            let model = Model(
//                isExpanded: false,
//                productCategory: MockData.mockItems,
//                productsArray: products,
//                query: "Search",
//                address: "Delivery address"
//            )
//
//            DispatchQueue.main.async {
//                self.view?.render(model: model)
//            }
//        case .failure(let error):
//
//            print("Error fetching products: \(error)")
//
//        }
//    }
//}
