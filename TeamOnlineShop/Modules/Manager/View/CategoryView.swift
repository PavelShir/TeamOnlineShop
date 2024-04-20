//
//  CategoryView.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol CategoryViewDelegate: AnyObject {
    func saveTapped(category: Category)
    func tappedBackButton()
}

final class CategoryView:  UIView {
    weak var delegate: CategoryViewDelegate?
    
    private var category: Category?
    
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
    
    private let fieldsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let searchBar = CustomSearchBarView()
    
    private let textFieldTitle: LabeledInputView = LabeledInputView(labelText: "Title", placeholder: "Enter category title")
        
    private let textFieldImage: LabeledInputView = LabeledInputView(labelText: "Image URL", placeholder: "Enter category image URL")
    
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
        [
            searchBar,
            textFieldTitle,
            textFieldImage
        ].forEach { fieldsStack.addArrangedSubview($0) }
        
        [
            title,
            backButton,
            separator,
            fieldsStack,
            actionButton
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
            fieldsStack.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
            fieldsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            fieldsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
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
        delegate?.saveTapped(category: makeCategory())
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
    
    func configure(by action: ManagerActions.Category) {
        switch action {
            case .add:
                actionButton.setTitle("Add", for: .normal)
                searchBar.isHidden = true
            case .update:
                actionButton.setTitle("Save changes", for: .normal)
                searchBar.isHidden = false
            case .delete:
                actionButton.setTitle("Delete", for: .normal)
                searchBar.isHidden = false
                textFieldTitle.isHidden = true
                textFieldImage.isHidden = true
            }
    }
    
    func makeCategory() -> Category {
        let title = textFieldTitle.text ?? ""
        let imageUrl = textFieldImage.text ?? ""
        if let categorySafe = category, let id = categorySafe.id  {
            return Category(id: id, name: title, image: imageUrl)
        }
        
        return Category(name: title, image: imageUrl)
    }
    
    func setSearchBarDelegate(vc: CategoryViewController) {
        searchBar.delegate = vc
    }
    
}
