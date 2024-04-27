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
    var payButton: CustomButton { get }
    var amountLabel: UILabel { get }
    var deliveryPicker: UIPickerView { get }
}

protocol CartViewDelegate: AnyObject {
    func tappedBackButton()
    func tappedCartButton()
    func tappedBuyButton()
}

final class CartViewImpl: UIView, CartView {
    
    //MARK: - Public property
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.isUserInteractionEnabled = false
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
    
    let deliveryPicker: UIPickerView = {
        let element = UIPickerView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - Private properties
    private let title: UILabel = LabelFactory.makeScreenTitle()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setBackgroundImage(UIImage.Icons.arrowLeft, for: .normal)
        button.tintColor = UIColor(named: Colors.blackLight)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    private lazy var line: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(named: Colors.greyLightest)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
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
    
    private lazy var lineTwo: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(named: Colors.greyLightest)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var lineThree: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(named: Colors.greyLightest)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
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
    
//    private lazy var payButton: UIButton = {
//        let element = UIButton()
//        element.setTitle("Pay", for: .normal)
//        element.titleLabel?.font = UIFont.TextFont.Element.Button.normal
//        element.tintColor = UIColor(named: Colors.whitePrimary)
////        element.backgroundColor = .greenPrimary
//        element.layer.cornerRadius = 4
//        element.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
        setViews()
        setupConstraints()
    }
    
    //MARK: - ConfigView public method
    
    func configView() {}
    
    //MARK: - Set Views
    
    func setViews() {
        self.backgroundColor = .white
        
        self.addSubview(line)
        self.addSubview(deliveryStack)
        addSubview(collectionView)
        
        deliveryStack.addArrangedSubview(deliveryLabel)
        deliveryStack.addArrangedSubview(deliveryPicker)
        
        self.addSubview(lineTwo)
        
        self.addSubview(lineThree)
        self.addSubview(orderLabel)
        self.addSubview(totalsStack)
        
        totalsStack.addArrangedSubview(totalsLabel)
        totalsStack.addArrangedSubview(amountLabel)
        
        self.addSubview(payButton)
    }
    
    private func setUpViews() {
        title.text = "Your Cart"
//        backButton.addTarget(nil, action: #selector(backButtonTapped), for: .touchUpInside)
//        cartButton.addTarget(nil, action: #selector(cartButtonTapped), for: .touchUpInside)
    }
    
//MARK: - Setup Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            line.heightAnchor.constraint(equalToConstant: 1),
            line.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            deliveryStack.heightAnchor.constraint(equalToConstant: 50),
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
        ])
    }
    
    //MARK: - Button Tapped
    
//    @objc private func backButtonTapped() {
//        delegate?.tappedBackButton()
//    }
//    
//    @objc private func cartButtonTapped() {
//        delegate?.tappedCartButton()
//    }
    
//    @objc private func payButtonTapped() {
//        let payVC = PaymentsViewController()
//        present(payVC, animated: true)
//        delegate?.tappedBuyButton()
//    }
    
}


