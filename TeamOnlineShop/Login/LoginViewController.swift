//
//  LoginViewController.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 17.04.2024.
//

import UIKit
import Firebase
import FirebaseAuth

final class LoginViewController: UIViewController {
    
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
        button.backgroundColor = UIColor(named: Colors.greenPrimary)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(UIColor(named: Colors.greenPrimary), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите логин"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас еще нет аккаунта?"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setViewsHierarchie()
        setViewsLayouts()
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            
            registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerLabel.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: 5),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func registerButtonTapped() {
        let rootVC = RegViewController()
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.modalPresentationStyle = .fullScreen
        navigationVC.navigationBar.backgroundColor = .white
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left.circle.fill"),
                                         style: .done,
                                         target: self,
                                         action: #selector(backButtonTapped))
        rootVC.navigationItem.leftBarButtonItem = backButton
        present(navigationVC, animated: true)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil) 
    }
    
    @objc func loginButtonTapped() {
        
        if let login = loginTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
                if let error = error {
                    print (error.localizedDescription)
                } else {
                    let tabBarVC = TabBarController()
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self?.present(tabBarVC, animated: true)
                }
            }
        }
    }
}
