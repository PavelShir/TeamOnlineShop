import UIKit
import PlatziFakeStore

struct Model{
    let isExpanded: Bool
    let productCategory: [Category]
    let productsArray: [Product]
    let query: String
    let address: String
}

struct SearchModel{
    let productsArray: [Product]
    let query: String
}
