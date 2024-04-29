//
//  UserRoleView.swift
//  TeamOnlineShop
//
//  Created by Maksim Stogniy on 28.04.2024.
//

import UIKit

protocol UserRoleViewDelegate: AnyObject {
    func tappedBackButton()
}

final class UserRoleView: UIView {
    
    weak var delegate: UserRoleViewDelegate?
    
    private let title: UILabel =  LabelFactory.makeScreenTitle()
    private var backButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.setBackgroundImage(UIImage.Icons.arrowLeft, for: .normal)
        button.tintColor = UIColor(named: Colors.greyPrimary)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        layoutViews()
    }
    
    func setViews() {
        backgroundColor = .white
        
        [
            title,
            backButton,
            tableView
        ].forEach { addSubview($0) }
        setUpViews()
    }
    
    func layoutViews() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: title.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func setDelegates(_ value: UserRoleViewController) {
        tableView.delegate = value
        tableView.dataSource = value
    }
    
    private func setUpViews(){
        title.text = "Account type"
        backButton.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
    }
    
    @objc private func backTapped(){
        delegate?.tappedBackButton()
    }
}
