import UIKit

final class MainViewCollectionDataSource: NSObject {
    private let collectionView: UICollectionView
   
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

extension MainViewCollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sectionType = Section(rawValue: section) else  { return 0 }
        
        switch sectionType {
        case .categories:
            return 5
        case .products:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Section out of range")
        }
        
        switch section {
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesViewCell.reuseIdentifier, for: indexPath) as! CategoriesViewCell
            return cell
        case .products:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsViewCell.reuseIdentifier, for: indexPath) as! ProductsViewCell
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionType = Section(rawValue: indexPath.section),
                kind == UICollectionView.elementKindSectionHeader else {
               fatalError("Unexpected kind \(kind) or unknown section")
           }
        
        switch sectionType {
        case .categories:
              return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryHeader.reuseIdentifier, for: indexPath) as! CategoryHeader
        case .products:
              return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProductsHeader.reuseIdentifier, for: indexPath) as! ProductsHeader
          }
        }
    }

    


