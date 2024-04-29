//
//  UserRolePresenter.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 28.04.2024.
//

import Foundation
import UIKit

protocol UserRoleRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func dismissUserRoleVC()
    
}

class UserRoleRouter: UserRoleRouterProtocol {
  
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func dismissUserRoleVC() {
        navigationVC?.popViewController(animated: true)
    }
    
}
