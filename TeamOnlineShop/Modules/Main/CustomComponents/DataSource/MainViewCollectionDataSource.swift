import UIKit

final class MainViewCollectionDataSource: NSObject {
    
    // MARK: - Properties
    private let collectionView: UICollectionView
    var isExpanded = false 
   
    // MARK: - Init
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.dataSource = self
        
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

    }
    
    func updateContent(_ content: [String]) {
        collectionView.reloadData()
    }
}
// MARK: - MainViewCollectionDataSource + UICollectionViewDataSource
extension MainViewCollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        
        guard let sectionType = Section(rawValue: section) else  { return 0 }
        
        switch sectionType {
        case .categories:
            return isExpanded ? 8 : 4
        case .products:
            return 10
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Section out of range")
        }
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: section.cellIdentifier,
                for: indexPath)
            
        switch section {
            
        case .categories:
            (cell as? CategoriesViewCell)
        case .products:
            (cell as? ProductsViewCell)
        }
            return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {
            
            guard let sectionType = Section(rawValue: indexPath.section),
                  kind == UICollectionView.elementKindSectionHeader else {
                fatalError("Unexpected kind \(kind) or unknown section")
            }
            
            let header =  collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: sectionType.headerIdentifier,
                for: indexPath)
            
            switch sectionType {
                
            case .categories:
                (header as? CategoryHeader)
            case .products:
                (header as? ProductsHeader)
            }
            return header
        }
    }

    


