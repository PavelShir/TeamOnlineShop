//
//  CartViewController.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

import UIKit

class CartViewController: UIViewController {
    
    //MARK: - UI
    
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
    }
    
    //MARK: - Set Views
    
    private func setViews() {
        view.backgroundColor = .yellow
    }
}

//MARK: - Setup Constraints

extension CartViewController {
    
    private func setupConstraints() {
        
    }
}

#Preview {
    var controller = CartViewController()
    
    return controller
}
