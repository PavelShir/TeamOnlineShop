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
        let layout = CollectionViewCompLayout.createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor =  .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        view.backgroundColor = .white
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
        
        dataSource.updateContent([])
    }
    // MARK: - Private funcs
    private func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -15),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15)
        ])
    }
}

// MARK: - MainViewController + MainViewProtocol
extension MainViewController: MainViewProtocol {}

extension MainViewController: UICollectionViewDelegate {}


// MARK: - Preview
import SwiftUI

struct MainViewControllerPreview: PreviewProvider {
    static var previews: some View {
        MainViewControllerContainer().edgesIgnoringSafeArea(.all)
    }
    
    struct MainViewControllerContainer: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> MainViewController {
            MainViewController(presenter: MainPresenter())
        }
        
        func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
        }
    }
}

