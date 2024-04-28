//
//  CartButtonView.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 28.04.2024.
//

import UIKit

class CustomCartButton: UIButton {
    
    private var itemCountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: Colors.redPrimary)
        label.textColor = UIColor(named: Colors.whitePrimary)
        label.textAlignment = .center
        label.font = UIFont.TextFont.Element.CartButton.badge
        label.layer.cornerRadius = 7.5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
        self.layer.cornerRadius = 12
        self.setBackgroundImage(UIImage.Icons.cart, for: .normal)
        self.tintColor = UIColor(named: Colors.blackLight)
        self.backgroundColor = .clear
        self.addSubview(itemCountLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemCountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -5),
            itemCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            itemCountLabel.widthAnchor.constraint(equalToConstant: 15),
            itemCountLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    func setItemCount(_ count: Int) {
        itemCountLabel.isHidden = (count <= 0)
        itemCountLabel.text = "\(min(count, 99))" + (count > 99 ? "+" : "")
    }
}
