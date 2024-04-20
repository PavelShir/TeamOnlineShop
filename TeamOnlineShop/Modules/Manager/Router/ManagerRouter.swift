//
//  ManagerRouter.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 20.04.2024.
//

import Foundation
import UIKit

protocol ManagerRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    
}

final class ManagerRouter: ManagerRouterProtocol {
    
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
}
