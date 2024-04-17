//
//  TermsAndConditionsPresenter.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 16.04.2024.
//

import Foundation
import UIKit

protocol TermsAndConditionsRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func dismissTermsAndConditionsVC()
    
}

final class TermsAndConditionsRouter: TermsAndConditionsRouterProtocol {

    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func dismissTermsAndConditionsVC() {
        navigationVC?.popViewController(animated: true)
    }
    
}
