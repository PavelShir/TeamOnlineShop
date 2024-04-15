import UIKit
protocol MainViewProtocol: AnyObject {}

class MainViewController: UIViewController {

    // MARK: - Properties
     var presenter: MainPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
}

extension MainViewController: MainViewProtocol {}
