//
//  UserRoleViewController.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 28.04.2024.
//

import UIKit

final class UserRoleViewController: UIViewController {
    
    private let presenter: UserRolePresenterProtocol
    private let customView = UserRoleView()
    private var previousSelectedIndexPath: IndexPath?
    
    init(presenter: UserRolePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupCustomView() {
        view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        customView.delegate = self
        customView.setDelegates(self)
        if let index = UserRole.allCases.firstIndex(where: { $0 == presenter.getUserRole() }) {
            let indexPath = IndexPath(item: index, section: 0)
            previousSelectedIndexPath = indexPath
        }
    }
}

//MARK: - UserRoleViewDelegate
extension UserRoleViewController: UserRoleViewDelegate {
    
    func tappedBackButton() {
        presenter.dismissUserRoleVC()
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
}

//MARK: - UserRolePresenterViewProtocol
extension UserRoleViewController: UserRolePresenterViewProtocol {
}

extension UserRoleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserRole.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let role = UserRole.allCases[indexPath.row]
        cell.textLabel?.text = role.rawValue
        cell.tintColor = .black
        cell.accessoryType = (role == presenter.getUserRole()) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == previousSelectedIndexPath {
            return
        }

        let selectedRole = UserRole.allCases[indexPath.row]

        if selectedRole == .manager {
            requestManagerAccess { [weak self] isGranted in
                guard let self = self else { return }
                if isGranted {
                    self.updateUI(for: indexPath, tableView: tableView)
                    self.presenter.updateUserRole(with: selectedRole)
                } else {
                    tableView.deselectRow(at: indexPath, animated: true)
                    self.showAlert(title: "Error", message: "Incorrect access code")
                }
            }
        } else {
            updateUI(for: indexPath, tableView: tableView)
            presenter.updateUserRole(with: selectedRole)
        }
    }

    private func updateUI(for indexPath: IndexPath, tableView: UITableView) {
        // Снимаем выделение с предыдущего выбранного элемента, если он есть
        if let previousIndexPath = previousSelectedIndexPath {
            tableView.cellForRow(at: previousIndexPath)?.accessoryType = .none
            tableView.deselectRow(at: previousIndexPath, animated: true)
        }

        // Выделяем новый выбранный элемент
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        previousSelectedIndexPath = indexPath
    }

    private func requestManagerAccess(completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "Manager Access", message: "Enter the manager access code", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Access Code"
            textField.isSecureTextEntry = true
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            let accessCode = alert.textFields?.first?.text ?? ""
            completion(accessCode == "secret")
        }
        alert.addAction(submitAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(false)
        }
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

