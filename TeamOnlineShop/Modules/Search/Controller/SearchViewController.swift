//
//  SearchViewController.swift
//  TeamOnlineShop
//
//  Created by Daniil Murzin on 22.04.2024.
//

import UIKit
import PlatziFakeStore

protocol SearchViewImplementation: AnyObject {
    func fetchModel(model: SearchModel)
}

final class SearchViewController: UIViewController {
    
    // MARK: - properties
    private let presenter: SearchPresenterImplementation
    private var searchText: String
    var productArray = [PlatziFakeStore.Product]()
    
    // MARK: - Init
    init(presenter: SearchPresenterImplementation,
         productArray: [PlatziFakeStore.Product],
         searchText: String) {
        
        self.presenter = presenter
        self.productArray = productArray
        self.searchText = searchText
        super.init(nibName: nil, bundle: nil)
        searchBarView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        filterButton.delegate = self
        setupViews()
        updateSearchResultsLabel(text: searchText)
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
    
    internal lazy var collectionView: UICollectionView = {
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
    
    private var searchResultsLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    func render(model: SearchModel) {
        
        productArray = model.productsArray
        
        collectionView.reloadData()
    }
    
    // MARK: - Selectors
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func updateSearchResultsLabel(text: String) {
            searchResultsLabel.text = "Search results for '\(text)'"
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
            searchBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            filterButton.centerYAnchor.constraint(equalTo: searchResultsLabel.centerYAnchor, constant: -3),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            searchResultsLabel.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 20),
            searchResultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchResultsLabel.widthAnchor.constraint(equalToConstant: 250),
            searchResultsLabel.heightAnchor.constraint(equalToConstant: 20),
           
            collectionView.topAnchor.constraint(equalTo: searchResultsLabel.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - SearchViewController + SearchViewImplementation
extension SearchViewController: SearchViewImplementation {
    
    func fetchModel(model: SearchModel) {
        productArray = model.productsArray
        updateSearchResultsLabel(text: model.query)
        collectionView.reloadData()
    }
}

// MARK: - SearchViewController + UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsViewCell.reuseIdentifier, for: indexPath) as? ProductsViewCell else {
            fatalError("Unable to dequeue ProductsViewCell")
        }
        let product = productArray[indexPath.row]
        cell.configure(model: product, showLikeButton: false)
        cell.delegate = self
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

// MARK: - SearchViewController + SearchBarViewDelegate
extension SearchViewController: SearchBarViewDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {}
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        presenter.searchAndOpenFilteredResults(query: searchText)
    }
}

// MARK: - SearchViewController + ProductsViewCellDelegate
extension SearchViewController: ProductsViewCellDelegate {
    func didTapWishButton(in cell: ProductsViewCell) {}
    
    func didTapAddToCartButton(in cell: ProductsViewCell) {
        print("Add to Cart button tapped")
    }
}

// MARK: - SearchViewController + CustomFiltersButtonDelegate
extension SearchViewController: CustomFiltersButtonDelegate {
    
    func filterByName() {
        presenter.filterByName()
    }
    
    func filterByPriceRange(low: Double, high: Double) {
        presenter.filterByPriceRange(low: low, high: high)
    }
}
