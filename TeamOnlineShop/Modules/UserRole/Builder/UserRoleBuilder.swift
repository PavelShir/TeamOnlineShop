//
//  UserRoleBuilder.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 28.04.2024.
//

import Foundation
import UIKit

protocol UserRoleBuilderProtocol: AnyObject {
    
    func buildUserRoleVC() -> UIViewController?
}

class UserRoleBuilder: UserRoleBuilderProtocol{
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildUserRoleVC() -> UIViewController? {
        guard let navigationVC = navigationVC else { return nil}
        let router = UserRoleRouter(navigationVC: navigationVC)
        let presenter = UserRolePresenter(router: router)
        let vc = UserRoleViewController(presenter: presenter)
        return vc
    }
}
