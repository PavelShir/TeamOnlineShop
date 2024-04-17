//
//  TermsAndConditionsBuilder.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 16.04.2024.
//

import Foundation
import UIKit

protocol TermsAndConditionsBuilderProtocol: AnyObject {
    
    func buildTermsAndConditionsVC() -> UIViewController?
}

final class TermsAndConditionsBuilder: TermsAndConditionsBuilderProtocol {
    
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildTermsAndConditionsVC() -> UIViewController? {
        guard let navigationVC = navigationVC else { return nil}
        let router = TermsAndConditionsRouter(navigationVC: navigationVC)
        let presenter = TermsAndConditionsPresenter(router: router)
        let vc = TermsAndConditionsViewController(presenter: presenter)
        return vc
    }
}
