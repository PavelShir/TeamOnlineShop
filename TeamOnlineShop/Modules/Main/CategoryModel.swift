import UIKit

struct ProductModel {
    let id: String?
    let title: String?
    let price: String?
    let description: String?
    let category: [ProductCategory]
    let images: [String?]
}

struct ProductCategory {
    let id: String
    let name: String
    let image: UIImage?
}

struct Model{
    let isExpanded: Bool
    let productCategory: [ProductCategory]
    let productsArray: [ProductModel]
    let query: String
    let address: String
}

struct MockData {
    static let mockProducts: [ProductModel] = Array(repeating: ProductModel(
        id: "1",
        title: "Monitor LG 22” 4K",
        price: "$199.99",
        description: "High-resolution monitor, perfect for gaming and professional use.",
        category: [
            ProductCategory(id: "001", name: "Electronics", image: UIImage(named: "electronics"))
        ],
        images: ["CellImage"]
    ), count: 20)
    
    static let mockItems: [ProductCategory] = [
        ProductCategory(id: "1", name: "Books", image: UIImage(systemName: "books.vertical")),
        ProductCategory(id: "2", name: "Computers", image: UIImage(systemName: "desktopcomputer")),
        ProductCategory(id: "3", name: "Phones", image: UIImage(systemName: "iphone")),
        ProductCategory(id: "4", name: "Watches", image: UIImage(systemName: "watch")),
        ProductCategory(id: "5", name: "Music", image: UIImage(systemName: "music.note")),
        ProductCategory(id: "6", name: "Sports", image: UIImage(systemName: "sportscourt")),
        ProductCategory(id: "7", name: "Games", image: UIImage(systemName: "gamecontroller")),
        ProductCategory(id: "8", name: "Clothing", image: UIImage(systemName: "tshirt")),
        ProductCategory(id: "9", name: "Shoes", image: UIImage(systemName: "figure.walk")),
        ProductCategory(id: "10", name: "Jewelry", image: UIImage(systemName: "jewelry")),
        ProductCategory(id: "11", name: "Cars", image: UIImage(systemName: "car")),
        ProductCategory(id: "12", name: "Bikes", image: UIImage(systemName: "bicycle")),
        ProductCategory(id: "13", name: "Plants", image: UIImage(systemName: "leaf")),
        ProductCategory(id: "14", name: "Pets", image: UIImage(systemName: "pawprint")),
        ProductCategory(id: "15", name: "Toys", image: UIImage(systemName: "cube.box")),
        ProductCategory(id: "16", name: "Tools", image: UIImage(systemName: "wrench.and.screwdriver")),
        ProductCategory(id: "17", name: "Furniture", image: UIImage(systemName: "bed.double")),
        ProductCategory(id: "18", name: "Kitchen", image: UIImage(systemName: "fork.knife")),
        ProductCategory(id: "19", name: "Art", image: UIImage(systemName: "paintbrush")),
        ProductCategory(id: "20", name: "Photography", image: UIImage(systemName: "camera"))
    ]
}
