import UIKit
import PlatziFakeStore

final class MainViewCollectionDataSource: NSObject {
    
    private var products = [PlatziFakeStore.Product]()
    private var categories = [PlatziFakeStore.Category]()
    var isExpanded = false
    var delegate: CategoryHeaderDelegate?
    // MARK: - Properties
    private let collectionView: UICollectionView
    
    // MARK: - Init
    init(_ collectionView: UICollectionView, presenter: MainPresenterImplementation?, delegate: CategoryHeaderDelegate?) {
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        self.collectionView.dataSource = self
        
        registerElement()
    }
    
    func setRenderModel(
        products: [PlatziFakeStore.Product],
        categories: [PlatziFakeStore.Category]) {
        self.products = products
        self.categories = categories
    }
    
    private func registerElement() {
        self.collectionView.register(
            ProductsViewCell.self,
            forCellWithReuseIdentifier: ProductsViewCell.reuseIdentifier)
        self.collectionView.register(
            CategoriesViewCell.self,
            forCellWithReuseIdentifier: CategoriesViewCell.reuseIdentifier)
        self.collectionView.register(
            ProductsHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProductsHeader.reuseIdentifier)
        self.collectionView.register(
            CategoryHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CategoryHeader.reuseIdentifier)
        self.collectionView.register(
            AllCategoriesFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: AllCategoriesFooterView.reuseIdentifier)
    }
    
    func updateContent(_ content: [String]) {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewCollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = Section(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .categories:
            return isExpanded ? categories.count + 1 : 5
        case .products:
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Section out of range")
        }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: section.cellIdentifier,
            for: indexPath)
        
        switch section {
        case .categories:
            
            guard let categoryCell = cell as? CategoriesViewCell else { return cell }
            
            let isSpecialCell = (isExpanded && indexPath.item == categories.count) || (!isExpanded && indexPath.item == 4)
            
            if isSpecialCell {
                let title = isExpanded ? "Hide" : "All Categories"
                categoryCell.configureSpecialCell(
                    name: title,
                    image: UIImage.Icons.allCategories ?? UIImage())
            } else {
                if indexPath.item < categories.count {
                           let category = categories[indexPath.item]
                           categoryCell.configure(model: category)
                       }
            }
            
            return categoryCell
            
        case .products:
            guard let productCell = cell as? ProductsViewCell else { return cell }
            let product = products[indexPath.item]
            productCell.configure(model: product)
            return  productCell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let sectionType = Section(rawValue: indexPath.section), kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected kind \(kind) or unknown section")
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionType.headerIdentifier, for: indexPath)
        
        if let categoryHeader = header as? CategoryHeader {
                categoryHeader.delegate = delegate
            }
        return header
    }
}
