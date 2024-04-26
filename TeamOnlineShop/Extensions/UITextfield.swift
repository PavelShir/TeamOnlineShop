//
//  Ext Textfield.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 26.04.2024.
//

import UIKit

extension UITextField {
    
    convenience init(picName: String, isSecure: Bool) {
        self.init()
        returnKeyType = .done
        layer.cornerRadius = 15
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        leftView = leftPaddingView
        leftViewMode = .always
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(systemName: picName)
        imageView.contentMode = .scaleAspectFit
        container.addSubview(imageView)
        
        let showPasswordButton = UIButton(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        showPasswordButton.imageView?.contentMode = .scaleAspectFit
        showPasswordButton.addTarget(self, action: #selector(showPasswordTapped), for: .touchUpInside)
        container.addSubview(showPasswordButton)
        
        if isSecure {
            showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
        
        rightView = container
        rightViewMode = .always
        rightView?.tintColor = .darkGray
    }
    
    @objc private func showPasswordTapped(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        let imageName = isSecureTextEntry ? "eye.slash" : "eye"
        if let showPasswordButton = rightView?.subviews.compactMap({ $0 as? UIButton }).first {
            showPasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
