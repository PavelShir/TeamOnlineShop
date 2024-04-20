import Foundation

enum Section: Int, CaseIterable {
    case categories
    case products
    
    var cellIdentifier: String {
        switch self {
        case .products:
            return ProductsViewCell.reuseIdentifier
        case .categories:
            return CategoriesViewCell.reuseIdentifier
        }
    }
    
    var headerIdentifier: String {
        switch self {
        case .products:
            return ProductsHeader.reuseIdentifier
        case .categories:
            return CategoryHeader.reuseIdentifier
        }
    }
    
    var columnCount: Int {
        switch self {
        case .categories:
            return 4
        case .products:
            return 2
        }
    }
}
