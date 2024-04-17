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
            Header.self,
            forSupplementaryViewOfKind: CollectionViewCompLayout.categoryHeaderId,
            withReuseIdentifier: CollectionViewCompLayout.headerID)
    }
    
    func updateContent(_ content: [String]) {
        collectionView.reloadData()
    }
}

extension MainViewCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } 
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesViewCell.reuseIdentifier, for: indexPath) as! CategoriesViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsViewCell.reuseIdentifier, for: indexPath) as! ProductsViewCell
            return cell
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: CollectionViewCompLayout.headerID,
            for: indexPath)
        header.backgroundColor = .blue
        return header
    }
}

