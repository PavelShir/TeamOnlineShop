import Foundation

protocol MainPresenterProtocol {}

class MainPresenter {
    
    // MARK: - Properties
    weak var view: MainViewProtocol?
    
    // MARK: - Init
    
    
}
// MARK: - MainPresenter + MainPresenterProtocol
extension MainPresenter: MainPresenterProtocol {}
