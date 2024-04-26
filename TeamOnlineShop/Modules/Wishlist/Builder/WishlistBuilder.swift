//
//  WishlistBuilder.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 25.04.2024.
//

import Foundation
import UIKit

protocol WishlistBuilderProtocol: AnyObject {
    
    func buildWishlistVC() -> UIViewController
}

class WishlistBuilder: WishlistBuilderProtocol{
    let navigationVC: UINavigationController
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildWishlistVC() -> UIViewController {
        let router = WishlistRouter(navigationVC: navigationVC)
        let presenter = WishlistPresenter(
            router: router
        )
        
        let vc = WishlistViewController(presenter: presenter)
        return vc
    }
}
