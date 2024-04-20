import Foundation

struct ProductModel {
    let id: String?
    let title: String?
    let price: String?
    let description: String?
    let category: [ProductCategory]
    let images: [String?]
}

struct ProductCategory {
    let id: String?
    let name: String?
    let image: String?
}

