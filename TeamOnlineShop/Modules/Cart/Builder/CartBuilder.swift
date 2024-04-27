//
//  CartBuilder.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 26.04.2024.
//

import Foundation
import UIKit

protocol CartBuilderProtocol: AnyObject {
    
    func buildCartVC(data: Cart) -> UIViewController

}

class CartBuilder: CartBuilderProtocol {
    let navigationVC: UINavigationController
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildCartVC(data: Cart) -> UIViewController {
        let router = CartRouter(navigationVC: navigationVC)
        let presenter = CartPresenter(
            router: router,
            data: data
        )

        let vc = CartViewController(presenter: presenter)
        return vc
    }
}
