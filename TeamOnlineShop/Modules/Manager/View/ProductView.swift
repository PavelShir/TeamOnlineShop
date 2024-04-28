//
//  ProductView.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol ProductViewDelegate: AnyObject {
    func saveTapped(product: Product)
    func tappedBackButton()
}

final class ProductView:  UIView {
    weak var delegate: ProductViewDelegate?
    
    private var product: Product?
    
    // Replace it with real categories
    private var categories: [Category] = [
        Category(id: 1, name: "cat 1", image: ""),
        Category(id: 2, name: "cat 2", image: ""),
        Category(id: 3, name: "cat 3", image: "")
    ]
    
    
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
        self.backgroundColor = UIColor(named: Colors.whitePrimary)
        [
            searchBar,
            textFieldTitle,
            textFieldPrice,
            textFieldCategory,
            textFieldDescription,
            textFieldImage
        ].forEach { fieldsStack.addArrangedSubview($0) }
        
        [
            title,
            backButton,
            separator,
            fieldsStack,
            productsTableView,
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
        delegate?.saveTapped(product: makeProduct())
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
    
    func setCategories(_ value: [Category]) {
        self.categories = value
    }
    
    func setProduct(_ value: Product) {
        product = value
        textFieldTitle.text = product?.title
        textFieldPrice.text = String(describing: product?.price)
        textFieldCategory.selectedItem = product?.category
        textFieldDescription.text = product?.description
        textFieldImage.text = product?.images.joined(separator: ",\n") ?? ""
    }
    
    func configure(by action: ManagerActions.Product) {
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
                textFieldPrice.isHidden = true
                textFieldCategory.isHidden = true
                textFieldDescription.isHidden = true
                textFieldImage.isHidden = true
                productsTableView.isHidden = false
            }
    }
    
    func makeProduct() -> Product {
        let title = textFieldTitle.text ?? ""
        let price = textFieldPrice.text ?? ""
        let category = textFieldCategory.selectedItem
        let description = textFieldDescription.text ?? ""
        let imagesUrl = textFieldImage.text ?? ""
//        if let productSafe = product, let id = productSafe.id, let categorySafe = category {
//            return Product(id: id, title: title, price: Int(price) ?? 0, description: description, images: [imagesUrl], category: categorySafe, categoryId: 0)
//        }
//        
//        return Product(title: title, price: Int(price) ?? 0, description: description, images: [imagesUrl], categoryId: category?.id ?? 0)
        return Product(id: 1, title: "", price: 1, description: "", images: [""], category: Category(id: 1, name: "", image: ""))
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
        product = products[indexPath.row]
    }
}
