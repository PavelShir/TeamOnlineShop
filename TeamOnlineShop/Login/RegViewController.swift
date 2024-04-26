//
//  RegViewController.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 26.04.2024.
//

import UIKit
import Firebase
import FirebaseAuth

final class RegViewController: UIViewController {
    
    var userType: UserType = .user
    let values = ["Клиент", "Менеджер"]
    
    private var pickerView: UIPickerView!
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.cornerRadius = 15
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Your name"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.cornerRadius = 15
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Your email"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField(picName: "eye", isSecure: true)
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let confPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let confPasswordTextField: UITextField = {
        let textField = UITextField(picName: "eye", isSecure: true)
        textField.placeholder = "Repeat password"
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегестироваться", for: .normal)
        button.backgroundColor = UIColor(named: Colors.greenPrimary)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(named: Colors.greenPrimary), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Sing up"
        pickerView = createPickerView()
        
        setViewsHierarchie()
        setLayout()
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func setViewsHierarchie() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(confPasswordLabel)
        view.addSubview(confPasswordTextField)
        view.addSubview(pickerView)
        view.addSubview(registerButton)
        view.addSubview(loginLabel)
        view.addSubview(loginButton)
    }
    
    private func createPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.center = view.center
        return pickerView
    }

    // MARK: - Кнопки
    
    @objc func loginButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func registerButtonTapped() {
        
        if let login = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
                if let error = error {
                    print (error.localizedDescription)
                } else {
                    let tabBarVC = TabBarController()
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.present(tabBarVC, animated: true)
                }
            }
        }
    }
    
    // MARK: - Констрейнты
    
    private func setLayout() {
        
        let stackView = UIStackView(arrangedSubviews: [loginLabel, loginButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLabel.heightAnchor.constraint(equalToConstant: 15),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordLabel.heightAnchor.constraint(equalToConstant: 15),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            confPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            confPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confPasswordLabel.heightAnchor.constraint(equalToConstant: 15),
            
            confPasswordTextField.topAnchor.constraint(equalTo: confPasswordLabel.bottomAnchor, constant: 5),
            confPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            pickerView.topAnchor.constraint(equalTo: confPasswordTextField.bottomAnchor, constant: 10),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            pickerView.heightAnchor.constraint(equalToConstant: 80),
                                               
            registerButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 10),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

// MARK: - дополнение для Alert

extension RegViewController {
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - сохранение а Firestore

extension RegViewController {
    
    func saveUserToFirestore(_ user: User, _ userType: UserType) {
        
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        let userData: [String: Any] = [
            "name": user.username,
            "login": user.email,
            "user type": userType.rawValue,
        ]
        
        do {
            try usersCollection.document(user.id).setData(userData)
            print("Пользователь успешно сохранен в Firestore")
        } catch let error {
            print("Ошибка при сохранении пользователя в Firestore: \(error)")
        }
    }
}

extension RegViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = values[row]
        userType = UserType(rawValue: selectedValue) ?? .user
    }
}