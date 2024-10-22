//
//  CategoryView.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit
import PlatziFakeStore

protocol CategoryViewDelegate: AnyObject {
    func saveTapped(category: PlatziFakeStore.NewCategory, id: Int?)
    func tappedBackButton()
}

final class CategoryView:  UIView {
    weak var delegate: CategoryViewDelegate?
    
    private var category: Category?
    private var categoryId: Int?
    var categories: [Category] = [] {
        didSet {
            categoriesTableView.reloadData()
        }
    }
    
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
    private var categorySelector: LabeledDropdownView = LabeledDropdownView(labelText: "Categories", options: [Category]())
    
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
    
    private let categoriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        return tableView
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
        categorySelector.delegate = self
        self.backgroundColor = UIColor(named: Colors.whitePrimary)
        [
            categorySelector,
            textFieldTitle,
            textFieldImage
        ].forEach { fieldsStack.addArrangedSubview($0) }
        
        [
            title,
            backButton,
            separator,
            fieldsStack,
            categoriesTableView,
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
            categoriesTableView.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 10),
            categoriesTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoriesTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            categoriesTableView.bottomAnchor.constraint(lessThanOrEqualTo: actionButton.topAnchor, constant: -20),
            categoriesTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
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
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        categoriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
    }
    
    @objc private func backTapped(){
        delegate?.tappedBackButton()
    }
    
    @objc private func actionTapped(){
        delegate?.saveTapped(category: makeCategory(), id: categoryId)
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
    
    func setCategory(_ value: Category) {
        category = value
        textFieldTitle.text = category?.name
        textFieldImage.text = category?.image ?? ""
    }
    func setCategories(_ values: [Category]) {
        categorySelector.items = values
    }
    
    func configure(by action: ManagerActions.Category) {
        switch action {
            case .add:
                actionButton.setTitle("Add", for: .normal)
            categorySelector.isHidden = true
                categoriesTableView.isHidden = true
            case .update:
                actionButton.setTitle("Save changes", for: .normal)
            categorySelector.isHidden = false
                categoriesTableView.isHidden = true
            case .delete:
                actionButton.setTitle("Delete", for: .normal)
            categorySelector.isHidden = true
                textFieldTitle.isHidden = true
                textFieldImage.isHidden = true
                categoriesTableView.isHidden = false
            }
    }
    
    func makeCategory() -> PlatziFakeStore.NewCategory {
        let title = textFieldTitle.text ?? ""
        let imageUrl = textFieldImage.text ?? ""
        
        return PlatziFakeStore.NewCategory(name: title, image: imageUrl)
    }
    
    func setSearchBarDelegate(vc: CategoryViewController) {
        searchBar.delegate = vc
    }
    
}

extension CategoryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
}

extension CategoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setCategory(categories[indexPath.row])
        categoryId = categories[indexPath.row].id
    }
}

extension CategoryView: LabeledDropdownViewDelegate {
    func didSelectItem<T>(_ item: T) where T : PickerViewRepresentable {
        setCategory(item as! Category)
        categoryId = category?.id
    }
}
