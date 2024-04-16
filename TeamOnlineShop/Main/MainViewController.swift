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
        let layout = createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor =  .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
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
    private static func createLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(
                    layoutSize:
                            .init(
                                widthDimension: .fractionalWidth(1),
                                heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                item.contentInsets.leading = 16
                
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize:
                            .init(
                                widthDimension: .fractionalWidth(0.4),
                                heightDimension: .absolute(200)
                            ), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                return section
                
            } else {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(300)))
                item.contentInsets.bottom = 16
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 5, leading: 16, bottom: 0, trailing: 15)
                section.boundarySupplementaryItems = [.init(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(50)),
                    elementKind: categoryHeaderId,
                    alignment: .topLeading)]
                return section
            }
        }
    }
    
    static let categoryHeaderId = "categoryHeaderId"
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

