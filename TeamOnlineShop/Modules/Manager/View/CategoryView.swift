//
//  CategoryView.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol CategoryViewDelegate: AnyObject {
   func saveTapped()
   func tappedBackButton()
}

final class CategoryView:  UIView {
    weak var delegate: CategoryViewDelegate?
    
    private let title: UILabel =  LabelFactory.makeScreenTitle()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.setBackgroundImage(UIImage.Icons.arrowLeft, for: .normal)
        button.tintColor = UIColor(named: Colors.greyPrimary)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let separator = Separator()
    
    private let actionsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let textFieldTitle: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Title"
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
    private let textFieldImage: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Image URL"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let actionButton: UIButton = CustomButton(label: "", size: .normal, type: .primary)
    
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
        setUpViews()
        self.backgroundColor = UIColor(named: Colors.whitePrimary)
        [textFieldTitle, textFieldImage].forEach { actionsStack.addArrangedSubview($0) }
        [
            title,
            backButton,
            separator,
            actionsStack
        ].forEach { addSubview($0) }
    }
    
    func layoutViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 28),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: title.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            separator.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            actionsStack.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20),
            actionsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            actionsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    
    private func setUpViews(){
        backButton.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
        actionButton.addTarget(nil, action: #selector(actionTapped), for: .touchUpInside)
    }
    
    @objc private func backTapped(){
        delegate?.tappedBackButton()
    }
    
    @objc private func actionTapped(){
        delegate?.saveTapped()
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
    
    func configure(by action: ManagerActions.Category) {
        switch action {
            case .add:
                actionButton.setTitle("Add", for: .normal)
//                searchField.isHidden = true
//                cancelButton.isHidden = true
            case .update:
                actionButton.setTitle("Save changes", for: .normal)
//                searchField.isHidden = false
//                cancelButton.isHidden = false
                // Show or hide elements based on searchField's text
//                if searchField.text?.isEmpty == false {
//                    textFieldTitle.isHidden = false
//                    textFieldImage.isHidden = false
//                } else {
//                    textFieldTitle.isHidden = true
//                    textFieldImage.isHidden = true
//                    // Show some message or view to indicate "use search to find category to edit"
//                }
        case .delete: break
        
        }
    }
    
}
