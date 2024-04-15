import Foundation

protocol MainPresenterProtocol {}

class MainPresenter {
    
    // MARK: - Properties
    weak private var view: MainViewProtocol?
    
    // MARK: - Init
    init(view: MainViewProtocol? = nil) {
        self.view = view
    }
}
// MARK: - MainPresenter + MainPresenterProtocol
extension MainPresenter: MainPresenterProtocol {}
