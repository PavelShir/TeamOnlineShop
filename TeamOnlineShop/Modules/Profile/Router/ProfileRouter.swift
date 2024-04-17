//
//  ProfileRouter.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 16.04.2024.
//

import Foundation
import UIKit

protocol ProfileRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func pushTermsAndConditionsVC()
    func pushAuthVC()
    
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
    
    func pushAuthVC() {
    }
    
}
