//
//  ProfilePresenter.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 16.04.2024.
//

import UIKit

protocol ProfilePresenterViewProtocol: AnyObject {
    
}

protocol ProfilePresenterProtocol: AnyObject {
    
    init(router: ProfileRouterProtocol)
    func goToTermsAndConditionsVC()
    func goToUserRoleVC()
    
}


final class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfilePresenterViewProtocol?
    var router: ProfileRouterProtocol?
    
    required init(router: ProfileRouterProtocol
    ) {
        self.router = router
    }
    
    func goToTermsAndConditionsVC() {
        router?.pushTermsAndConditionsVC()
    }
    
    func goToUserRoleVC() {
        router?.pushUserRoleVC()
    }
    
}
