//
//  AuthManager.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 29.04.2024.
//

import Foundation
import Firebase

protocol AuthManagerProtocol {
    
    func registerUser(with registerRequest: RegisterUserRequest)
    func signInUser(with loginRequest: LoginUserRequest)
}

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
}

extension AuthManager {
   
    
    func checkAuth() -> Bool {
        Auth.auth().currentUser != nil
    }
    func registerUser(
        with userRequest: RegisterUserRequest,
        completion: @escaping (User?, Error?) -> Void
    ) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        let role = userRequest.role
        
        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { result, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(nil, nil)
                return
            }
            
            let user = User(
                id: resultUser.uid,
                username: username,
                email: email,
                image: "",
                role: role,
                cart: [],
                wishList: [],
                location: Address.usa.rawValue
            )
            
            FirestoreManager.shared.setCollection(
                with: user
            ) { wasSet, error in
                if let error = error {
                    completion(nil, error)
                }
                completion(user, nil)
            }
        }
    }
    
    func signIn(
        with userRequest: LoginUserRequest,
        completion: @escaping (Error?) -> Void
    ) {
        Auth.auth().signIn(
            withEmail: userRequest.email,
            password: userRequest.password
        ) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "AuthError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        FirestoreManager.shared.fetchCollection(for: userID) { user, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            completion(user, nil)
        }
    }
}
