import UIKit

final class MainModuleBuilder {
    
    static func build() -> MainViewController {
        
        let presenter  = MainPresenter()
        let mainViewController = MainViewController(presenter: presenter)
        
        return mainViewController
    }
}
