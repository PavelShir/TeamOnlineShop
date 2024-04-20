//
//  LoginViewController.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 17.04.2024.
//

import UIKit

class LoginViewController: UIViewController {
        
        let loginTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "login"
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.darkGray.cgColor
            textField.layer.cornerRadius = 15
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
            textField.leftView = leftPaddingView
            textField.leftViewMode = .always
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        let passwordTextField: UITextField = {
            let textField = UITextField(picName: "eye", isSecure: true)
            textField.placeholder = "password"
            textField.isSecureTextEntry = true
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.darkGray.cgColor
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            return textField
        }()
        
        
        
        let loginButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Войти", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        let registerButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Зарегистрироваться", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    let loginLabel: UILabel = {
            let label = UILabel()
            label.text = "Введите логин"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let passwordLabel: UILabel = {
            let label = UILabel()
            label.text = "Пароль"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let registerLabel: UILabel = {
            let label = UILabel()
            label.text = "У вас еще нет аккаунта?"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setViewsHierarchie()
            
            setViewsLayouts()
    
            registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        }
        
    func setViewsHierarchie() {
       
        view.addSubview(loginLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerLabel)
        view.addSubview(registerButton)
        
        
    }
    
    func setViewsLayouts() {
        
        NSLayoutConstraint.activate([
            
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 5),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
    }
    
    @objc func registerButtonTapped() {
        // Код для перехода на экран регистрации
    }

}

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
