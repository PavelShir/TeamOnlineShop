//
//  ButtonWithRightIcon.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 16.04.2024.
//

import UIKit

class ProfileButtonWithRightIcon: UIButton {
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: Colors.blackPrimary)
        label.font = UIFont.TextFont.Screens.ProfileScreen.menuItem
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let buttonIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 0
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    // MARK: Init
    init(label: String, icon: UIImage?, backgroundColor: String, contenColor: String) {
        self.buttonLabel.text = label
        self.buttonLabel.textColor = UIColor(named: contenColor)
        if icon != nil {
            self.buttonIcon.image = icon
            self.buttonIcon.tintColor = UIColor(named: contenColor)
        }
        
        super.init(frame: .zero)
        self.backgroundColor = UIColor(named: backgroundColor)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 12
        setViews()
        layoutViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {
        [buttonLabel, buttonIcon].forEach {
            addSubview($0)
        }
    }

    private func layoutViews() {
        NSLayoutConstraint.activate([
            buttonLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonLabel.topAnchor.constraint(equalTo: topAnchor),
            buttonLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func changeState(icon: UIImage?, backgroundColor: String, contenColor: String) {
        buttonLabel.textColor = UIColor(named: contenColor)
        if icon != nil {
            buttonIcon.image = icon
            buttonIcon.tintColor = UIColor(named: contenColor)
        }
        
        self.backgroundColor = UIColor(named: backgroundColor)
    }
}


