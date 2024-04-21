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

let mockItems: [ProductCategory] = [
    ProductCategory(id: "1", name: "Books", image: "books.vertical"),
    ProductCategory(id: "2", name: "Computers", image: "desktopcomputer"),
    ProductCategory(id: "3", name: "Phones", image: "iphone"),
    ProductCategory(id: "4", name: "Watches", image: "watch"),
    ProductCategory(id: "5", name: "Music", image: "music.note"),
    ProductCategory(id: "6", name: "Sports", image: "sportscourt"),
    ProductCategory(id: "7", name: "Games", image: "gamecontroller"),
    ProductCategory(id: "8", name: "Clothing", image: "tshirt"),
    ProductCategory(id: "9", name: "Shoes", image: "figure.walk"),
    ProductCategory(id: "10", name: "Jewelry", image: "jewelry"),
    ProductCategory(id: "11", name: "Cars", image: "car"),
    ProductCategory(id: "12", name: "Bikes", image: "bicycle"),
    ProductCategory(id: "13", name: "Plants", image: "leaf"),
    ProductCategory(id: "14", name: "Pets", image: "pawprint"),
    ProductCategory(id: "15", name: "Toys", image: "cube.box"),
    ProductCategory(id: "16", name: "Tools", image: "wrench.and.screwdriver"),
    ProductCategory(id: "17", name: "Furniture", image: "bed.double"),
    ProductCategory(id: "18", name: "Kitchen", image: "fork.knife"),
    ProductCategory(id: "19", name: "Art", image: "paintbrush"),
    ProductCategory(id: "20", name: "Photography", image: "camera")
]
