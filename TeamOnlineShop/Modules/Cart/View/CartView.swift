//
//  CartView.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 26.04.2024.
//

import UIKit
import AsyncImageView

protocol CartView: UIView {
    var collectionView: UICollectionView { get }
    var backButton: UIButton { get }
    var payButton: CustomButton { get }
    var amountLabel: UILabel { get }
    var emptyCartLabel: UILabel { get }
    var deliveryAddressSelector: AddressSelector { get }
}

final class CartViewImpl: UIView, CartView {
    
    //MARK: - Public property
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setBackgroundImage(UIImage.Icons.arrowLeft, for: .normal)
        button.tintColor = UIColor(named: Colors.blackLight)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    let payButton = CustomButton(label: "Pay", size: CustomButton.Size.normal, type: CustomButton.ButtonType.primary)
    
    let amountLabel: UILabel = {
        let element = UILabel()
        element.text = "$ 2499,97"
        element.font = UIFont.TextFont.Screens.ShopCartItem.title
        element.tintColor = .blackLight
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let deliveryAddressSelector = AddressSelector()
    
    let emptyCartLabel: UILabel = {
        let label = UILabel()
        label.text = "You don't add anything to cart"
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.TextFont.Screens.text
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Private properties
    private let title: UILabel = LabelFactory.makeScreenTitle()
    
    private var cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setBackgroundImage(UIImage.Icons.cart, for: .normal)
        button.tintColor = UIColor(named: Colors.blackLight)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - UI
    
    private lazy var line = Separator()
    
    private lazy var deliveryStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .equalSpacing
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var deliveryLabel: UILabel = {
        let element = UILabel()
        element.text = "Delivery to"
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var lineTwo = Separator()
    
    private lazy var lineThree = Separator()
    
    private lazy var orderLabel: UILabel = {
        let element = UILabel()
        element.text = "Order Summary"
        element.font = UIFont.TextFont.Screens.ShopCartItem.title
        element.tintColor = .blackLight
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var totalsStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .equalSpacing
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var totalsLabel: UILabel = {
        let element = UILabel()
        element.text = "Totals"
        element.font = UIFont.TextFont.Screens.ShopCartItem.title
        element.tintColor = .blackLight
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpViews()
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
        setViews()
        setupConstraints()
    }
    
    //MARK: - Set Views
    
    func setViews() {
        self.backgroundColor = .white
        
        self.addSubview(backButton)
        self.addSubview(title)
        self.addSubview(cartButton)
        self.addSubview(line)
        self.addSubview(deliveryStack)
        addSubview(collectionView)
        
        deliveryStack.addArrangedSubview(deliveryLabel)
        deliveryStack.addArrangedSubview(deliveryAddressSelector)
        
        self.addSubview(lineTwo)
        
        self.addSubview(lineThree)
        self.addSubview(orderLabel)
        self.addSubview(totalsStack)
        
        totalsStack.addArrangedSubview(totalsLabel)
        totalsStack.addArrangedSubview(amountLabel)
        
        self.addSubview(payButton)
        self.addSubview(emptyCartLabel)
    }
    
    private func setUpViews() {
        title.text = "Your Cart"
    }
    
//MARK: - Setup Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            backButton.topAnchor.constraint(equalTo: title.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            
            cartButton.topAnchor.constraint(equalTo: title.topAnchor),
            cartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            cartButton.widthAnchor.constraint(equalToConstant: 20),
            cartButton.heightAnchor.constraint(equalToConstant: 20),
                
            line.heightAnchor.constraint(equalToConstant: 1),
            line.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            deliveryStack.heightAnchor.constraint(equalToConstant: 40),
            deliveryStack.topAnchor.constraint(equalTo: line.bottomAnchor),
            deliveryStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            deliveryStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            lineTwo.heightAnchor.constraint(equalToConstant: 1),
            lineTwo.topAnchor.constraint(equalTo: deliveryStack.bottomAnchor),
            lineTwo.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineTwo.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            lineThree.heightAnchor.constraint(equalToConstant: 1),
            lineThree.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -160),
            lineThree.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineThree.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: deliveryStack.bottomAnchor,constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -160),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            orderLabel.bottomAnchor.constraint(equalTo: totalsStack.topAnchor, constant: -1),
            orderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            orderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            orderLabel.heightAnchor.constraint(equalToConstant: 30),
            
            totalsStack.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -10),
            totalsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            totalsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            totalsStack.heightAnchor.constraint(equalToConstant: 30),
            
            payButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            payButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            payButton.heightAnchor.constraint(equalToConstant: 45),
        
            emptyCartLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyCartLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyCartLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emptyCartLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}


