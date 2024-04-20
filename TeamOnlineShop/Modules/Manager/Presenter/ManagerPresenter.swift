//
//  ManagerPresenter.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol ManagerPresenterViewProtocol: AnyObject {
    
}

protocol ManagerPresenterProtocol: AnyObject {
    
    init(router: ManagerRouterProtocol)
    
}


final class ManagerPresenter: ManagerPresenterProtocol {
    weak var view: ManagerPresenterViewProtocol?
    var router: ManagerRouterProtocol?
    
    required init(router: ManagerRouterProtocol
    ) {
        self.router = router
    }
}
