//
//  CartButton.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 26.04.2024.
//

import UIKit

class CartButton: UIBarButtonItem {
    convenience init(count: Int) {

        let badgeCount: UILabel = {
            let element = UILabel(frame: CGRect(x: 22, y: -03, width: 14, height: 14))
            element.layer.borderColor = UIColor.clear.cgColor
            element.layer.borderWidth = 2
            element.layer.cornerRadius = element.bounds.size.height / 2
            element.textAlignment = .center
            element.layer.masksToBounds = true
            element.textColor = .white
            element.font = UIFont.TextFont.Element.TabBar.label
            element.backgroundColor = .redLight
            element.text = String(count)
            return element
        }()
        
        let cartButton: UIButton = {
            let element = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
            element.setBackgroundImage(UIImage(systemName: "cart"), for: .normal)
            element.tintColor = .black

            element.addSubview(badgeCount)

            return element
        }()
        
        self.init(customView: cartButton)
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
    }
}

extension CartButton {
    @objc func cartButtonTapped() {
        print("cartButtonTapped")
      
        let cartButtonVC = CartButtonViewController()
        cartButtonVC.nextView()
        
    }
}

class CartButtonViewController: UIViewController {
    
    func nextView() {
//        print("nextView")
//        let nextVC = CartViewController()
//        navigationController?.pushViewController(nextVC, animated: true)
    }
}

