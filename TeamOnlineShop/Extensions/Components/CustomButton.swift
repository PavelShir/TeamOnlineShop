//
//  CustomButton.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit



final class CustomButton: UIButton {
    enum Size {
       case small
       case normal
       case large
    }

    enum ButtonType {
       case primary
       case secondary
    }
    
    // MARK: Init
    init(label: String, size: Size, type: ButtonType) {
        super.init(frame: .zero)
        configureButton(label: label, size: size, type: type)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton(label: String, size: Size, type: ButtonType) {
        let titleFont: UIFont

        switch size {
            case .small:
                titleFont = UIFont.TextFont.Element.Button.small
            case .normal:
                titleFont = UIFont.TextFont.Element.Button.normal
            case .large:
                titleFont = UIFont.TextFont.Element.Button.large
        }

        self.setTitle(label, for: .normal)
        self.titleLabel?.font = titleFont
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 4
            
        switch type {
            case .primary:
                self.backgroundColor = UIColor(named: Colors.greenPrimary)
                self.setTitleColor(UIColor(named: Colors.whitePrimary), for: .normal)
            case .secondary:
                self.backgroundColor = UIColor(named: Colors.greyLighter)
                self.setTitleColor(UIColor(named: Colors.blackPrimary), for: .normal)
                self.layer.borderColor = UIColor(named: Colors.greyLight)?.cgColor
                self.layer.borderWidth = 1
        }
        
        addTarget(self, action: #selector(buttonHighlight), for: .touchDown)
        addTarget(self, action: #selector(buttonNormal), for: .touchUpInside)
    }
    
    
    @objc private func buttonHighlight() {
        setTitleColor(titleColor(for: .normal)?.withAlphaComponent(0.25), for: .normal)
    }
    
    @objc private func buttonNormal() {
        setTitleColor(titleColor(for: .normal)?.withAlphaComponent(1.0), for: .normal)
    }
}
