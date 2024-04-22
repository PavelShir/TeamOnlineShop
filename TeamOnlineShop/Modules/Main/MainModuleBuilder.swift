import UIKit

final class MainModuleBuilder {
    
    static func build(router: MainRouter) -> MainViewController {
        
        let presenter  = MainPresenter(router: router)
        let mainViewController = MainViewController(presenter: presenter)
        presenter.view = mainViewController
        
        return mainViewController
    }
}
