//
//  PhotoSelectionMenuButton.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 17.04.2024.
//

import UIKit

class PhotoSelectionMenuButton: UIButton {
    init(label: String, icon: UIImage, backgroundColor: String, contenColor: String) {
        super.init(frame: .zero)
        self.setTitle(label, for: .normal)
        self.contentHorizontalAlignment = .left
        self.configuration = UIButton.Configuration.plain()
        self.configuration?.imagePadding = 15
        self.configuration?.titlePadding = 15
        self.backgroundColor = UIColor(named: backgroundColor)
        self.setImage(icon, for: .normal)
        self.setTitleColor(UIColor(named: contenColor), for: .normal)
        self.titleLabel?.font = UIFont.TextFont.Element.AvatarActionsModal.actionItem
        self.layer.cornerRadius = 8
        self.tintColor = UIColor(named: contenColor)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 12
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
