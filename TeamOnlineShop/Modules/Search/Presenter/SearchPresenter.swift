//
//  SearchPresenter.swift
//  TeamOnlineShop
//
//  Created by Daniil Murzin on 22.04.2024.
//

import Foundation

protocol SearchPresenterImplementation {}

final class SearchPresenter {
    
    weak var view: SearchViewImplementation?
    
    
}

extension SearchPresenter: SearchPresenterImplementation {}
