//
//  RegisterViewController.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 22.04.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    let labelNamesConstants = [
        "First name", "Enter your name",
        "E-mail", "Enter your email",
        "Password", "Enter your password",
        "Confirm passweord", "Enter your password",
        "Type of account", "Enter type of your account"
    ]
    
    let tableView = UITableView()
    
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(RegisterCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        view.addSubview(registerButton)
        view.addSubview(loginLabel)
        view.addSubview(loginButton)
        
        setLayout()
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
// MARK: - Кнопки
    
    @objc func loginButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func registerButtonTapped() {
        
        /*    if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print (error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        } */
    }
    
// MARK: - Констрейнты
    
    private func setLayout() {
        tableView.separatorStyle = .none
        
        let stackView = UIStackView(arrangedSubviews: [loginLabel, loginButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 460),
       
            registerButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

// MARK: - дополнение для TableView

extension RegisterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return labelNamesConstants.count / 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RegisterCell
        cell.textField.placeholder = labelNamesConstants[indexPath.section * 2 + 1]
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return labelNamesConstants[section * 2]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // Обработка нажатия на ячейку с именем
            break
        case 1:
            // Обработка нажатия на ячейку с логином
            break
        case 2:
            // Обработка нажатия на ячейку с паролем
            break
        case 3:
            // Обработка нажатия на ячейку с повтором пароля
            break
        default:
            break
        }
    }
}

// MARK: - дополнение для Alert

extension RegisterViewController {
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
