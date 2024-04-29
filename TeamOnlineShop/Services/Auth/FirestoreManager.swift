//
//  FirestoreManager.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 29.04.2024.
//

import Firebase

final class FirestoreManager {
    
    enum CollectionPath {
        static let username = "username"
        static let email = "email"
        static let image = "image"
        static let role = "role"
        static let cart = "cart"
        static let wishList = "wishlist"
        static let location = "location"
    }
    
    static let shared = FirestoreManager()
    
    private let environment = "users"
    private let db = Firestore.firestore()
    
    private init() {}
    
    
    
    func setCollection(
        with user: User,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        var cartJSON: [[String: Any]] = []
        var wishListJSON: [[String: Any]] = []
        
        for product in user.cart {
            do {
                let productData = try JSONEncoder().encode(product)
                if let json = try JSONSerialization.jsonObject(with: productData, options: []) as? [String: Any] {
                    cartJSON.append(json)
                }
            } catch {
                print("Error encoding cart item to JSON: \(error)")
            }
        }
        
        for product in user.wishList {
            do {
                let productData = try JSONEncoder().encode(product)
                if let json = try JSONSerialization.jsonObject(with: productData, options: []) as? [String: Any] {
                    wishListJSON.append(json)
                }
            } catch {
                print("Error encoding wishlist item to JSON: \(error)")
            }
        }
        
        db.collection(environment)
            .document(user.id)
            .setData([
                CollectionPath.username: user.username,
                CollectionPath.email: user.email,
                CollectionPath.image: user.image,
                CollectionPath.role: user.role,
                CollectionPath.cart: cartJSON,
                CollectionPath.wishList: wishListJSON,
                CollectionPath.location: user.location,
            ]) { error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                completion(true, nil)
            }
    }
    
    func fetchCollection(
        for id: String,
        completion: @escaping (User?, Error?) -> Void
    ) {
        db.collection(environment)
            .document(id)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                }
                
                guard let snapshot = snapshot, let snapshotData = snapshot.data() else {
                    completion(nil, NSError(domain: "DataError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "No data found"]))
                    return
                }

                do {
                    let username = snapshotData[CollectionPath.username] as? String ?? ""
                    let email = snapshotData[CollectionPath.email] as? String ?? ""
                    let image = snapshotData[CollectionPath.image] as? String ?? ""
                    let location = snapshotData[CollectionPath.location] as? String ?? ""
                    let role = snapshotData[CollectionPath.role] as? String ?? ""
                    
                    let cartData = snapshotData[CollectionPath.cart] as? [[String: Any]] ?? []
                    let wishListData = snapshotData[CollectionPath.wishList] as? [[String: Any]] ?? []

                    let cart = try cartData.map { try JSONDecoder().decode(Product.self, from: JSONSerialization.data(withJSONObject: $0)) }
                    let wishList = try wishListData.map { try JSONDecoder().decode(Product.self, from: JSONSerialization.data(withJSONObject: $0)) }

                    let user = User(
                        id: id,
                        username: username,
                        email: email,
                        image: image,
                        role: role,
                        cart: cart,
                        wishList: wishList,
                        location: location
                    )

                    completion(user, nil)
                } catch {
                    completion(nil, error)
                }
            }
    }
}
