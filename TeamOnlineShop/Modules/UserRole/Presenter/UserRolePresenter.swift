//
//  UserRolePresenter.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 28.04.2024.
//

import Foundation


protocol UserRolePresenterViewProtocol: AnyObject {
}

protocol UserRolePresenterProtocol: AnyObject {
    
    init(router: UserRoleRouterProtocol)
    func dismissUserRoleVC()
    
    func getUserRole() -> UserRole
    func updateUserRole(with role: UserRole)
}


class UserRolePresenter: UserRolePresenterProtocol {
   
    weak var view: UserRolePresenterViewProtocol?
    var router: UserRoleRouterProtocol?
    
    required init(router: UserRoleRouterProtocol) {
        self.router = router
    }
    
    func dismissUserRoleVC(){
        router?.dismissUserRoleVC()
    }
    
    func getUserRole() -> UserRole {
        return UserManager.shared.getUserRole()
    }
    
    func updateUserRole(with role: UserRole) {
        UserManager.shared.changeUserRole(role: role) { error in
            if error != nil {
                print("Error is occured during updating user role")
            }
        }
    }
}
