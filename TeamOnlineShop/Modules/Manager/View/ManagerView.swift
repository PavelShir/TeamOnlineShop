//
//  ManagerView.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol ManagerViewDelegate: AnyObject {
    func addCategoryTapped()
    func updateCategoryTapped()
    func deleteCategoryTapped()
    
    func addProductTapped()
    func updateProductTapped()
    func deleteProductTapped()
}

final class ManagerView: UIView {
    weak var delegate: ManagerViewDelegate?
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blackPrimary)
        label.numberOfLines = 1
        label.font = UIFont.TextFont.Screens.title
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let addCategoryBtn: UIButton = CustomButton(label: "Add category", size: .normal, type: .primary)
    private let updateCategoryBtn: UIButton = CustomButton(label: "Update category", size: .normal, type: .primary)
    private let deleteCategoryBtn: UIButton = CustomButton(label: "Delete category", size: .normal, type: .primary)
    private let addProductBtn: UIButton = CustomButton(label: "Add product", size: .normal, type: .primary)
    private let updateProductBtn: UIButton = CustomButton(label: "Update product", size: .normal, type: .primary)
    private let deleteProductBtn: UIButton = CustomButton(label: "Delete product", size: .normal, type: .primary)
    
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
            addCategoryBtn,
            updateCategoryBtn,
            deleteCategoryBtn,
            addProductBtn,
            updateProductBtn,
            deleteProductBtn
        ].forEach { actionsStack.addArrangedSubview($0) }
        [
            title,
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
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            separator.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            actionsStack.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 25),
            actionsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            actionsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
        ])
        
        for case let button as UIButton in actionsStack.subviews {
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }

    
    private func setUpViews(){
        title.text = "Manager Screen"
        addCategoryBtn.addTarget(nil, action: #selector(addCategoryTapped), for: .touchUpInside)
        updateCategoryBtn.addTarget(nil, action: #selector(updateCategoryTapped), for: .touchUpInside)
        deleteCategoryBtn.addTarget(nil, action: #selector(deleteCategoryTapped), for: .touchUpInside)
        addProductBtn.addTarget(nil, action: #selector(addProductTapped), for: .touchUpInside)
        updateProductBtn.addTarget(nil, action: #selector(updateProductTapped), for: .touchUpInside)
        deleteProductBtn.addTarget(nil, action: #selector(deleteProductTapped), for: .touchUpInside)
    }
    
    @objc private func addCategoryTapped(){
        delegate?.addCategoryTapped()
    }
    
    @objc private func updateCategoryTapped(){
        delegate?.updateCategoryTapped()
    }
    
    @objc private func deleteCategoryTapped(){
        delegate?.deleteCategoryTapped()
    }
    
    @objc private func addProductTapped(){
        delegate?.addProductTapped()
    }
    
    @objc private func updateProductTapped(){
        delegate?.updateProductTapped()
    }
    
    @objc private func deleteProductTapped(){
        delegate?.deleteProductTapped()
    }
}

extension ManagerView {
    private func makeButton(with label: String) -> UIButton {
        let button = UIButton()
        
        button.setTitle(label, for: .normal)
        button.titleLabel?.font = UIFont.TextFont.Element.Button.normal
        button.setTitleColor(UIColor(named: Colors.whitePrimary), for: .normal)
        button.backgroundColor = UIColor(named: Colors.greenPrimary)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}
