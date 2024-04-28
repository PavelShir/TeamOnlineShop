//
//  UserManager.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit.UIImage

struct UserData {
    let username: String
    let email: String
    let image: UIImage?
    let type: String
}

final class UserManager {
    static let shared = UserManager()
    private var user: User?
    
    private init() {}
    
    func setUser(userObject: User) {
        user = userObject
    }
    
    func updateUserAvatar(avatar: UIImage, completion: @escaping (Error?) -> Void) {
        if let base64String = avatar.pngData()?.base64EncodedString() {
            let pathToAvatar = saveUserAvatarToUD(with: user?.id ?? "", avatar: base64String)
            user?.image = pathToAvatar
            DispatchQueue.main.async {
                // save user here
            }
        } else {
            let error = NSError(domain: "YourDomain", code: 2, userInfo: [NSLocalizedDescriptionKey: "Error converting image to base64"])
            completion(error)
        }
    }
    
    func changeUserType(type: UserType, completion: @escaping (Error?) -> Void) {
        user?.type = type.rawValue
        DispatchQueue.main.async {
            // save user here
        }
    }
    
    func addProductToWithList(product: Product, completion: @escaping (Error?) -> Void){
        user?.wishList.append(product)
        DispatchQueue.main.async {
            // save user here`
        }
    }
    
    func addProductToCart(product: Product, completion: @escaping (Error?) -> Void) {
        if let index = user?.cart.firstIndex(where: { $0.id == product.id }) {
            if var productToUpdate = user?.cart[index] {
                productToUpdate.count += 1
                user?.cart[index] = productToUpdate
            }
        } else {
            var newProduct = product
            newProduct.count = 1
            user?.cart.append(newProduct)
        }
        
        DispatchQueue.main.async {
            // save user here`
        }
    }
    
    func changeeProductCountInCart(product: Product, action: String, completion: @escaping (Error?) -> Void) {
        if let existingProductIndex = user?.cart.firstIndex(where: { $0.id == product.id }) {
            let currentCount = user?.cart[existingProductIndex].count
            user?.cart[existingProductIndex].count = action == "add" ? currentCount! + 1 : currentCount! - 1
            if user?.cart[existingProductIndex].count == 0 {
                user?.cart.remove(at: existingProductIndex)
            }
        
        
            DispatchQueue.main.async {
                // save user here`
            }
        }
    }
    
    func deleteProductFromCart(productId: Int, completion: @escaping (Error?) -> Void) {
        if let index = user?.cart.firstIndex(where: { $0.id == productId }) {
            user?.cart.remove(at: index)
            
            DispatchQueue.main.async {
               // save user here
            }
        }
    }
    
    func deleteProductFromWishList(productId: Int, completion: @escaping (Error?) -> Void) {
        if let index = user?.wishList.firstIndex(where: { $0.id == productId }) {
            user?.wishList.remove(at: index)
            
            DispatchQueue.main.async {
               // save user here
            }
        }
    }
    
    func getProductsFromWithList() -> [Product] {
        return user?.wishList ?? []
    }
    
    func getProductsFromCart() -> [Product] {
        return user?.cart ?? []
    }
    
    func getUserProfileData() -> UserData {
        return UserData(
            username: user!.username,
            email: user!.email,
            image: makeUserImage(),
            type: user!.type
        )
    }
    
    private func makeUserImage() -> UIImage? {
        guard let imageData = getUserAvatarFromUD(by: user?.id ?? ""), !imageData.isEmpty else {
            return nil
        }
            
        guard let imageDataDecoded = Data(base64Encoded: imageData) else {
            return nil
        }
        
        return UIImage(data: imageDataDecoded)
    }
    
    private func getKeyForUserAvatar(by userId: String) -> String {
        return "user-" + userId + "-avatar"
    }
    
    private func saveUserAvatarToUD(with userId: String, avatar: String) -> String {
        let key = getKeyForUserAvatar(by: userId)
        UserDefaults.standard.set(avatar, forKey: key)
        return key
    }
    
    private func getUserAvatarFromUD(by userId: String) -> String? {
        let key = getKeyForUserAvatar(by: userId)
        let defaults = UserDefaults.standard
            
        guard let avatarString = defaults.string(forKey: key) else {
            return nil
        }
        
        return avatarString
    }
}

