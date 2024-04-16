//
//  TermsAndConditionsPresenter.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 16.04.2024.
//

import Foundation


protocol TermsAndConditionsPresenterViewProtocol: AnyObject {
    
}

protocol TermsAndConditionsPresenterProtocol: AnyObject {
    
    init(router: TermsAndConditionsRouterProtocol)
    func dismissTermsAndConditionsVC()
    
}


class TermsAndConditionsPresenter: TermsAndConditionsPresenterProtocol {
   
    weak var view: TermsAndConditionsPresenterViewProtocol?
    var router: TermsAndConditionsRouterProtocol?
    
    required init(router: TermsAndConditionsRouterProtocol) {
        self.router = router
    }
    
    func dismissTermsAndConditionsVC(){
        router?.dismissTermsAndConditionsVC()
    }
}
