import UIKit
protocol MainViewProtocol: AnyObject {}

final class MainViewController: UIViewController {

    // MARK: - Properties
    private let presenter: MainPresenterProtocol
    private let dataSource: MainViewCollectionDataSource
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        self.dataSource = .init(collectionView)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 170, height: 230)
        layout.minimumInteritemSpacing = 7
        layout.minimumLineSpacing = 7

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor =  .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = .white
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
        
        dataSource.updateContent([])
    }
    
    private func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -15),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -15)
        ])
    }

}
// MARK: - MainViewController + MainViewProtocol
extension MainViewController: MainViewProtocol {}

// MARK: - MainViewController + UICollectionViewDataSource
//extension MainViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsViewCell.reuseIdentifier, for: indexPath) as! ProductsViewCell
//        return cell
//    }
//}

extension MainViewController: UICollectionViewDelegate {}


final class MainViewCollectionDataSource: NSObject {
    private let collectionView: UICollectionView
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.dataSource = self
        self.collectionView.register(ProductsViewCell.self, forCellWithReuseIdentifier: ProductsViewCell.reuseIdentifier)
    }
    
    func updateContent(_ content: [String]) {
        collectionView.reloadData()
    }
}

extension MainViewCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsViewCell.reuseIdentifier, for: indexPath) as! ProductsViewCell
        return cell
    }
}
