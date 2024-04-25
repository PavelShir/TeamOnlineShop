
import UIKit
import PlatziFakeStore

protocol MainViewImplementation: AnyObject {
    func render(model: Model)
}

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private let presenter: MainPresenterImplementation
    private var dataSource: MainViewCollectionDataSource!
    private var categories = [PlatziFakeStore.Category]()
    var isExpanded = false
    
    init(presenter: MainPresenterImplementation) {
        
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        self.dataSource = .init(collectionView, presenter: presenter, delegate: self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let layout = CollectionViewCompLayout.createLayout(isExpanded: false)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor =  .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        view.backgroundColor = .white
        
        dataSource.updateContent([])
        presenter.fetchModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private funcs
    private func setupCollectionViewConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10)
        ])
    }
}

// MARK: - MainViewController + MainViewProtocol
extension MainViewController: MainViewImplementation {
    
    func render(model: Model) {
        dataSource.setRenderModel(
            products: model.productsArray,
            categories: model.productCategory
        )
        categories = model.productCategory
        
        
        collectionView.performBatchUpdates({
            collectionView.reloadSections(IndexSet(arrayLiteral: 0,1))
        }, completion: nil)
    }
}


extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            if indexPath.section == Section.categories.rawValue && indexPath.item == (isExpanded ? categories.count : 4) {
                
                isExpanded.toggle()
                dataSource.isExpanded = isExpanded
                
                collectionView.setCollectionViewLayout(CollectionViewCompLayout.createLayout(isExpanded: isExpanded), animated: true)
                
                collectionView.performBatchUpdates({
                    collectionView.reloadSections(IndexSet(integer: indexPath.section))
                }, completion: nil)
            }
        }
    }

extension MainViewController: CategoryHeaderDelegate {
    func searchBarTextDidChange(_ searchBar: UISearchBar, newText: String) {
    }
    
    func searchBarSearchButtonClicked(with text: String) {
        
        presenter.searchAndOpenFilteredResults(query: text)
    }
}


    


//{
//
//    guard let homePresenter = presenter as? HomePresenter else { return }
//
//    NetworkManager.shared.fetchData(for: text) { result in
//        switch result {
//        case .success(let articles):
//            DispatchQueue.main.async {
//                self.presenter.articles = articles.articles
//                let searchVC = SearchArticlesViewController(searchText: text)
//                searchVC.articles = articles.articles
//                #warning("почему эта скотина не работает через роутер????")
////                    self.presenter.router?.showSearchVC(searchText: text)
//                self.navigationController?.pushViewController(searchVC, animated: true)
//            }
//
//        case .failure(let error):
//            print(error)
//        }
//    }
//}
    // MARK: - Preview
//    import SwiftUI
//
//    struct MainViewControllerPreview: PreviewProvider {
//        static var previews: some View {
//            MainViewControllerContainer().edgesIgnoringSafeArea(.all)
//        }
//
//        struct MainViewControllerContainer: UIViewControllerRepresentable {
//            func makeUIViewController(context: Context) -> MainViewController {
//                MainViewController(presenter: MainPresenter(router: <#MainRouter#>ro))
//            }
//
//            func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
//            }
//        }
    
