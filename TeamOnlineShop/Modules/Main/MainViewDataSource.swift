import UIKit

final class MainViewCollectionDataSource: NSObject {
    
    private var products = [ProductModel]()
    private var categories = [ProductCategory]()
    var isExpanded = false
    
    // MARK: - Properties
    private let collectionView: UICollectionView
    
    // MARK: - Init
    init(_ collectionView: UICollectionView, presenter: MainPresenterImplementation?) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.dataSource = self
        registerElement()
    }
    
    func setRenderModel(
        products: [ProductModel],
        categories: [ProductCategory]) {
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
            return isExpanded ? categories.count + 1 : 10
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
            
            let isSpecialCell = (isExpanded && indexPath.item == categories.count) || (!isExpanded && indexPath.item == 9)
            
            if isSpecialCell {
                let title = isExpanded ? "Hide" : "All Categories"
                categoryCell.configureCell(name: title, image: UIImage(named: "allCategoriesIcon") ?? UIImage())
            } else {
                let category = categories[indexPath.item]
                categoryCell.configureCell(name: category.name, image: category.image ?? UIImage())
            }
            
            return categoryCell
            
        case .products:
            guard let productCell = cell as? ProductsViewCell else { return cell }
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
        return header
    }
}
