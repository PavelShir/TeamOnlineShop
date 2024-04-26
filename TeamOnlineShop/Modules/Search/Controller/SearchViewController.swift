//
//  SearchViewController.swift
//  TeamOnlineShop
//
//  Created by Daniil Murzin on 22.04.2024.
//

import UIKit
import PlatziFakeStore

protocol SearchViewImplementation: AnyObject {}

final class SearchViewController: UIViewController {
    
    // MARK: - properties
    private let presenter: SearchPresenterImplementation
    
    var productArray = [PlatziFakeStore.Product]()
    
    // MARK: - Init
    init(presenter: SearchPresenterImplementation, productArray: [PlatziFakeStore.Product]) {
        self.presenter = presenter
        self.productArray = productArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private methods
    private let searchBarView: SearchBarView = {
        let view = SearchBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.Icons.arrowLeft, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let filterButton: CustomFiltersButton = {
        let button = CustomFiltersButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(ProductsViewCell.self, forCellWithReuseIdentifier: ProductsViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let searchResultsLabel: UILabel = {
        let element = UILabel()
        element.text = "Search results for 'Earphone' "
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Selectors
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup views + Constraints
    private func setupViews() {
        view.addSubviews(
            backButton,
            searchBarView,
            filterButton,
            searchResultsLabel,
            collectionView)
        
        NSLayoutConstraint.activate([
            
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor),
            
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBarView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: filterButton.trailingAnchor),
            
            filterButton.centerYAnchor.constraint(equalTo: searchResultsLabel.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            filterButton.widthAnchor.constraint(equalToConstant: 44),
            filterButton.heightAnchor.constraint(equalToConstant: 27),
            
            searchResultsLabel.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 20),
            searchResultsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchResultsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: searchResultsLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - SearchViewController + SearchViewImplementation
extension SearchViewController: SearchViewImplementation {}

// MARK: - SearchViewController + UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsViewCell.reuseIdentifier, for: indexPath) as? ProductsViewCell else {
            fatalError("Unable to dequeue ProductsViewCell")
        }
        cell.backgroundColor = .blue
        let product = productArray[indexPath.row]
        cell.configure(model: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let spacingBetweenCells: CGFloat = 10
        let totalSpacing = (numberOfColumns - 1) * spacingBetweenCells
        let availableWidth = collectionView.frame.width - totalSpacing
        let widthPerItem = availableWidth / numberOfColumns
        let heightPerItem = widthPerItem * 1.5
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}

// MARK: - SearchViewController + UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           presenter.goToProductDetail(indexPath.row)
       }
}

// MARK: - SearchViewController + UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {}

