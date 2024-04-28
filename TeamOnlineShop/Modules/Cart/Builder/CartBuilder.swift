//
//  CartBuilder.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 26.04.2024.
//

import Foundation
import UIKit

protocol CartBuilderProtocol: AnyObject {
    
    func buildCartVC(router: CartRouterProtocol) -> UIViewController

}

final class CartBuilder: CartBuilderProtocol {
    private let navigationVC: UINavigationController
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildRouter() -> CartRouter {
        CartRouter(navigationVC: navigationVC, builder: self)
    }
    
    func buildCartVC(router: CartRouterProtocol) -> UIViewController {
        let presenter = CartPresenter(
            router: router
        )
        let vc = CartViewControllerImpl(
            presenter: presenter,
            cartView: CartViewImpl()
        )
        presenter.view = vc
        return vc
    }
}
