//
//  LabelFactory.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

final class LabelFactory {
    
    static func makeScreenTitle() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blackPrimary)
        label.numberOfLines = 1
        label.font = UIFont.TextFont.Screens.title
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
