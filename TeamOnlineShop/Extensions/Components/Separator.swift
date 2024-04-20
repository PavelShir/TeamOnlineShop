//
//  Separator.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 17.04.2024.
//

import UIKit

final class Separator: UIView {
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor(named: Colors.greyLighter)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
