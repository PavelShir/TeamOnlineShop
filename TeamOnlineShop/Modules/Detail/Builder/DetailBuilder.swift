//
//  DetailBuilder.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 25.04.2024.
//

import Foundation
import UIKit

protocol DetailBuilderProtocol: AnyObject {
    
    func buildDetailVC(data: Product) -> UIViewController
}

class DetailBuilder: DetailBuilderProtocol{
    let navigationVC: UINavigationController
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildDetailVC(data: Product) -> UIViewController {
        let router = DetailRouter(navigationVC: navigationVC)
        let presenter = DetailPresenterImpl(
            router: router,
            data: data
        )
        
        let vc = DetailViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
