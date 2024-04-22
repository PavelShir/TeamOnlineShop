import UIKit

protocol MainViewImplementation: AnyObject {
    func render(model: Model)
}

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private let presenter: MainPresenterImplementation
    private let dataSource: MainViewCollectionDataSource
    var isExpanded = false
    
    init(presenter: MainPresenterImplementation) {
        self.presenter = presenter
        self.dataSource = .init(collectionView, presenter: presenter)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private let collectionView: UICollectionView = {
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
            categories: model.productCategory,
            isExpanded: model.isExpanded
        )
        collectionView.reloadData()
    }
}
    
    
    extension MainViewController: UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.section == Section.categories.rawValue {
                let count = presenter.getCategoryArrayCount()
                
                let isSpecialCell = indexPath.item == (isExpanded ? count : 9)
                
                if isSpecialCell {
                    isExpanded.toggle()
                    dataSource.isExpanded = isExpanded
                    print("Тогл сработал \(isExpanded)")
                    
                    collectionView.setCollectionViewLayout(
                        CollectionViewCompLayout.createLayout(isExpanded: isExpanded),
                        animated: true
                    )
                    
                    collectionView.performBatchUpdates({
                        collectionView.reloadSections(IndexSet(integer: indexPath.section))
                    },  completion: { finished in
                        print("Collection view updated. Layout is now \(self.isExpanded ? "expanded" : "collapsed").")
                    })
                }
            }
        }
    }
    
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
    
