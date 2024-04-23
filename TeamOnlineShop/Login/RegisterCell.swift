//
//  RegisterCell.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 22.04.2024.
//

import UIKit

class RegisterCell: UITableViewCell {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 20
        self.backgroundColor = UIColor.greyLightest
        
        contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

