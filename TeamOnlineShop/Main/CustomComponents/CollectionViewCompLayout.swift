import UIKit

public final class CollectionViewCompLayout {
    static let headerID = "headerID"
    static let categoryHeaderId = "categoryHeaderId"
    
     static func createLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(
                    layoutSize:
                            .init(
                                widthDimension: .fractionalWidth(1),
                                heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 10
                item.contentInsets.leading = 10
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize:
                            .init(
                                widthDimension: .fractionalWidth(0.22),
                                heightDimension: .absolute(65)
                            ), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            } else {
                let categoryHeaderId = "categoryHeaderId"
                
                let item = NSCollectionLayoutItem(
                    layoutSize:
                            .init(
                                widthDimension: .fractionalWidth(0.5),
                                heightDimension: .absolute(260)))
                item.contentInsets.bottom = 16
                item.contentInsets.trailing = 16
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(1000)),
                    subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(
                    top: 0,
                    leading: 10,
                    bottom: 0,
                    trailing: 10)
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
    
}
