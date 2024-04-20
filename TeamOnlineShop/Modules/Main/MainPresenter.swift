import Foundation

protocol MainPresenterImplementation {}

final class MainPresenter {
    
    // MARK: - Properties
    weak var view: MainViewImplementation?
    
    // MARK: - Init
    
    
}
// MARK: - MainPresenter + MainPresenterProtocol
extension MainPresenter: MainPresenterImplementation {}
