//
//  ProductView.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit
import PlatziFakeStore

protocol ProductViewDelegate: AnyObject {
    func saveTapped(product: PlatziFakeStore.NewProduct, id: Int?)
    func tappedBackButton()
}

final class ProductView:  UIView {
    weak var delegate: ProductViewDelegate?
    
    private var product: Product?
    private var productId: Int?
    
    // Replace it with real categories
    private var categories: [Category] = .init()
    
    var products: [Product] = [] {
        didSet {
            productsTableView.reloadData()
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
    
    private let vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let fieldsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var productsSelector: LabeledDropdownView = LabeledDropdownView(labelText: "Products", options: [Product]())
    
    private let searchBar = CustomSearchBarView()
    
    private let textFieldTitle: LabeledInputView = LabeledInputView(labelText: "Title", placeholder: "Enter product title")
        
    private let textFieldPrice: LabeledInputView = LabeledInputView(labelText: "Price", placeholder: "Enter product price")
    
    private lazy var textFieldCategory: LabeledDropdownView = LabeledDropdownView(labelText: "Category", options: categories)
        
    private let textFieldDescription: LabeledTextView = LabeledTextView(labelText: "Description", placeholder: "Enter product description")
    private let textFieldImage: LabeledTextView = LabeledTextView(labelText: "Images", placeholder: "Enter product images URL")
    
    private let productsTableView: UITableView = {
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
        productsSelector.delegate = self
        self.backgroundColor = UIColor(named: Colors.whitePrimary)
        [
            separator,
            productsSelector,
        ].forEach { vStack.addArrangedSubview($0) }
        [
//            searchBar,
            textFieldTitle,
            textFieldPrice,
            textFieldCategory,
            textFieldDescription,
            textFieldImage
        ].forEach { fieldsStack.addArrangedSubview($0) }
        
        [
            title,
            backButton,
            vStack,
//            separator,
            fieldsStack,
            productsTableView,
            actionButton
        ].forEach { addSubview($0) }
    }
    
    func layoutViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 28),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: title.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            vStack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
        ])
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            fieldsStack.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 10),
            fieldsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            fieldsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            productsTableView.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 10),
            productsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            productsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            productsTableView.bottomAnchor.constraint(lessThanOrEqualTo: actionButton.topAnchor, constant: -20),
            productsTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
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
        productsTableView.dataSource = self
        productsTableView.delegate = self
        productsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
    }
    
    @objc private func backTapped(){
        delegate?.tappedBackButton()
    }
    
    @objc private func actionTapped(){
        delegate?.saveTapped(product: makeProduct(), id: productId)
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
    
    func setCategories(_ value: [Category]) {
        categories = value
        textFieldCategory.items = value
    }
    
    func setProduct(_ value: Product) {
        product = value
        textFieldTitle.text = value.title
        textFieldPrice.text = String(describing: value.price)
        textFieldCategory.selectedItem = value.category
        textFieldDescription.text = value.description
        textFieldImage.text = value.images.joined(separator: "\n")
    }
    func setProducts(_ values: [Product]) {
        productsSelector.items = values
    }
    
    func configure(by action: ManagerActions.Product) {
        switch action {
            case .add:
                actionButton.setTitle("Add", for: .normal)
            productsSelector.isHidden = true
            case .update:
                actionButton.setTitle("Save changes", for: .normal)
            productsSelector.isHidden = false
            case .delete:
                actionButton.setTitle("Delete", for: .normal)
            productsSelector.isHidden = true
                textFieldTitle.isHidden = true
                textFieldPrice.isHidden = true
                textFieldCategory.isHidden = true
                textFieldDescription.isHidden = true
                textFieldImage.isHidden = true
                productsTableView.isHidden = false
            }
    }
    
    func makeProduct() -> PlatziFakeStore.NewProduct {
        let title = textFieldTitle.text ?? ""
        let price = textFieldPrice.text ?? ""
        let category = textFieldCategory.selectedItem! as Category
        let description = textFieldDescription.text ?? ""
        let images = textFieldImage.text ?? ""

        return PlatziFakeStore.NewProduct(title: title, price: Int(price) ?? 0, description: description, categoryId: category.id, images: images.components(separatedBy: "\n"))
    }
    
    func setSearchBarDelegate(vc: ProductViewController) {
        searchBar.delegate = vc
    }
    
}

extension ProductView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        let product = products[indexPath.row]
        cell.textLabel?.text = product.title
        return cell
    }
}

extension ProductView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productId = products[indexPath.row].id
        setProduct(products[indexPath.row])
    }
}

extension ProductView: LabeledDropdownViewDelegate {
    func didSelectItem<T>(_ item: T) where T : PickerViewRepresentable {
        setProduct(item as! Product)
        productId = product?.id
    }
}
