import UIKit
import PlatziFakeStore

struct Model{
    let isExpanded: Bool
    let productCategory: [PlatziFakeStore.Category]
    let productsArray: [PlatziFakeStore.Product]
    let query: String
    let address: String
}

struct SearchModel{
    let productsArray: [PlatziFakeStore.Product]
    let query: String
}
