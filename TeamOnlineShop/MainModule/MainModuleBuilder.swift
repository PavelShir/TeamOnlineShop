import UIKit

class MainModuleBuilder {
    
    static func build() -> MainViewController {
        
        let mainViewController = MainViewController()
        let presenter  = MainPresenter(view: mainViewController)
        mainViewController.presenter = presenter
        
        return mainViewController
    }
}
