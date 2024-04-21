import Foundation

protocol MainPresenterImplementation {}

final class MainPresenter {
    
    // MARK: - Properties
    weak var view: MainViewImplementation?
    
    var categoriesArray = [ProductCategory]()

}
// MARK: - MainPresenter + MainPresenterProtocol
extension MainPresenter: MainPresenterImplementation {
    
    func 
}
