//
//  DetailBuilder.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 25.04.2024.
//

import Foundation
import UIKit

protocol DetailBuilderProtocol: AnyObject {
    
    func buildDetailVC(data: Product) -> UIViewController?
}

class DetailBuilder: DetailBuilderProtocol{
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildDetailVC(data: Product) -> UIViewController? {
        guard let navigationVC = navigationVC else { return nil}
        let router = DetailRouter(navigationVC: navigationVC)
        let presenter = DetailPresenter(
            router: router,
            data: data
        )
        
        let vc = DetailViewController(presenter: presenter)
        return vc
    }
}
