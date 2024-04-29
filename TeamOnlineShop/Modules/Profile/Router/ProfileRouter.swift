//
//  ProfileRouter.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 16.04.2024.
//

import Foundation
import UIKit

protocol ProfileRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func pushUserRoleVC()
    func pushTermsAndConditionsVC()
}

final class ProfileRouter: ProfileRouterProtocol {
    
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func pushTermsAndConditionsVC(){
        guard let navigationVC = navigationVC else { return }
        let termsAndConditionsVC = TermsAndConditionsBuilder(navigationVC: navigationVC).buildTermsAndConditionsVC()
        navigationVC.pushViewController(termsAndConditionsVC!, animated: true)
    }
    
    func pushUserRoleVC() {
        guard let navigationVC = navigationVC else { return }
        let userRoleVC = UserRoleBuilder(navigationVC: navigationVC).buildUserRoleVC()
        navigationVC.pushViewController(userRoleVC!, animated: true)
    }
    
}
