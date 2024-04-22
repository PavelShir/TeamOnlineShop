//
import UIKit

final class CollectionViewCompLayout {
    
    static func createLayout(isExpanded: Bool) -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            guard let sectionType = Section(rawValue: sectionNumber) else { return nil }
            
            switch sectionType {
            case .categories:
                
                if isExpanded {
                    
                    let itemSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0 / 5),
                        heightDimension: .fractionalHeight(1.0))
                    let item = NSCollectionLayoutItem(
                        layoutSize: itemSize)
                    item.contentInsets = NSDirectionalEdgeInsets(
                        top: 2,
                        leading: 2,
                        bottom: 2,
                        trailing: 2)
                    
                    let groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0 / 3))
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitem: item,
                        count: 5)
                    
                    let fullGroupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(300))
                    let fullGroup = NSCollectionLayoutGroup.vertical(
                        layoutSize: fullGroupSize,
                        subitem: group,
                        count: 3)
                    
                    let section = NSCollectionLayoutSection(group: fullGroup)
                    section.interGroupSpacing = 5
                    
                    let headerSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(50))
                    let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                    section.boundarySupplementaryItems = [header]
                    
                    return section
                    
                } else {
                    let item = NSCollectionLayoutItem(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(0.9),
                            heightDimension: .fractionalHeight(1)))
                    item.contentInsets = NSDirectionalEdgeInsets(
                        top: 15,
                        leading: 10,
                        bottom: 0,
                        trailing: 10)
                    
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(0.22),
                            heightDimension: .absolute(100)),
                        subitems: [item])
                    let section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .continuous
                    section.contentInsets = NSDirectionalEdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 0)
                    
                    let headerSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(90))
                    let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .topLeading)
                    section.boundarySupplementaryItems = [header]
                    return section
                }
                
            case .products:
                
                let item = NSCollectionLayoutItem(
                    layoutSize:
                            .init(
                                widthDimension: .fractionalWidth(0.50),
                                heightDimension: .absolute(220)))
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 5,
                    bottom: 0,
                    trailing: 5)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(1000)),
                    subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(
                    top: 5,
                    leading: 5,
                    bottom: 0,
                    trailing: 5)
                
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(30))
                let productsHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading)
                section.boundarySupplementaryItems = [productsHeader]
                return section
            }
        }
    }
}
