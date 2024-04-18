import Foundation

enum Section: Int, CaseIterable {
    case categories
    case products
    
    var columnCount: Int {
        switch self {
        case .categories:
            return 4
        case .products:
            return 2
        }
    }
}
