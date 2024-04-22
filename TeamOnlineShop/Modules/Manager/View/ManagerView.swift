//
//  ManagerView.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol ManagerViewDelegate: AnyObject {
    func addCategoryTapped(label: String)
    func updateCategoryTapped(label: String)
    func deleteCategoryTapped(label: String)
    
    func addProductTapped(label: String)
    func updateProductTapped(label: String)
    func deleteProductTapped(label: String)
}

final class ManagerView: UIView {
    weak var delegate: ManagerViewDelegate?
    
    private let title: UILabel = LabelFactory.makeScreenTitle()
    
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
    
    @objc private func addCategoryTapped(_ sender: CustomButton){
        delegate?.addCategoryTapped(label: sender.titleLabel?.text ?? "")
    }
    
    @objc private func updateCategoryTapped(_ sender: CustomButton){
        delegate?.updateCategoryTapped(label: sender.titleLabel?.text ?? "")
    }
    
    @objc private func deleteCategoryTapped(_ sender: CustomButton){
        delegate?.deleteCategoryTapped(label: sender.titleLabel?.text ?? "")
    }
    
    @objc private func addProductTapped(_ sender: CustomButton){
        delegate?.addProductTapped(label: sender.titleLabel?.text ?? "")
    }
    
    @objc private func updateProductTapped(_ sender: CustomButton){
        delegate?.updateProductTapped(label: sender.titleLabel?.text ?? "")
    }
    
    @objc private func deleteProductTapped(_ sender: CustomButton){
        delegate?.deleteProductTapped(label: sender.titleLabel?.text ?? "")
    }
}
