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
    
    init(presenter: SearchPresenterImplementation, productArray: [PlatziFakeStore.Product]) {
        self.presenter = presenter
        self.productArray = productArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
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
    
    private func setupViews() {
        view.addSubviews(
            backButton,
            searchBarView,
            filterButton,
            searchResultsLabel,
            collectionView)
    
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            searchBarView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            searchBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            
            filterButton.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor),
            filterButton.leadingAnchor.constraint(equalTo: searchBarView.trailingAnchor, constant: 8),
            filterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            filterButton.widthAnchor.constraint(equalToConstant: 44),
            
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

extension SearchViewController: SearchViewImplementation {}

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

extension SearchViewController: UICollectionViewDelegate {}

extension SearchViewController: UICollectionViewDelegateFlowLayout {}

