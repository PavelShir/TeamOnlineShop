//
//  DetailView.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 25.04.2024.
//

import UIKit
import AsyncImageView

protocol DetailViewDelegate: AnyObject {
    func tappedBackButton()
    func tappedCartButton()
    func tappedWishButton(_ isWished: Bool)
    func tappedAddToCartButton()
    func tappedBuyNowButton()
}

final class DetailView: UIView {
    
    weak var delegate: DetailViewDelegate?
    private var wished: Bool = false
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
    
    private var productImage: AsyncImageView = {
        let imageView = AsyncImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(named: Colors.blackLight)
        return imageView
    }()
    
    private lazy var productName: UILabel = {
        let element = UILabel()
        element.text = ""
        element.font = UIFont.TextFont.Screens.ProductDetail.title
        element.textColor = UIColor(named: Colors.blackLight)
        element.numberOfLines = 0
        element.lineBreakMode = .byWordWrapping
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let descriptionLabel: UILabel = {
        let element = UILabel()
        element.text = "Description of product"
        element.font = UIFont.TextFont.Screens.ProductDetail.descriptionLabel
        element.textColor = UIColor(named: Colors.blackLight)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var productPrice: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFont.Screens.ProductDetail.price
        element.textColor = UIColor(named: Colors.blackLight)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var descriptionText: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.text = ""
        textView.textColor = UIColor(named: Colors.blackLight)
        textView.font = UIFont.TextFont.Screens.ProductDetail.descriptionText
        textView.textAlignment = .left
        textView.showsVerticalScrollIndicator = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var wishButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 23
        button.setImage(UIImage.Icons.wishlist, for: .normal)
        button.tintColor = UIColor(named: Colors.greyPrimary)
        button.backgroundColor = UIColor(named: Colors.greyLighter)
        button.layer.borderColor = UIColor(named: Colors.greyLight)?.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let separator = Separator()
    
    private lazy var buttonStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fillEqually
        element.alignment = .center
        element.spacing = 15
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let addToCartButton = CustomButton(label: "Add to cart", size: CustomButton.Size.normal, type: CustomButton.ButtonType.primary)
    
    private let buyNowButton = CustomButton(label: "Buy now", size: CustomButton.Size.normal, type: CustomButton.ButtonType.secondary)
        
    
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
    
    //MARK: - ConfigView public method
    func configView(data: Product, isLiked: Bool?) {
        productImage.setImage(from: data.images[0])
        productName.text = data.title
        productPrice.text = "$ \(data.price)"
        descriptionText.text = data.description
//        wishButton.setBackgroundImage(favoriteImage, for: .normal)
    }
     
    func setViews() {
        self.backgroundColor = UIColor(named: Colors.whitePrimary)
        
        [addToCartButton, buyNowButton].forEach { buttonStack.addArrangedSubview($0) }
        setUpViews()
        [
            backButton,
            title,
            cartButton,
            productImage,
            productName,
            productPrice,
            descriptionLabel,
            descriptionText,
            wishButton,
            separator,
            buttonStack
        ].forEach { addSubview($0) }
    }
    
    private func setUpViews(){
        title.text = "Product details"
        backButton.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
        cartButton.addTarget(nil, action: #selector(cartTapped), for: .touchUpInside)
        wishButton.addTarget(nil, action: #selector(wishTapped), for: .touchUpInside)
    }
    
    
    func layoutViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: title.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            cartButton.topAnchor.constraint(equalTo: title.topAnchor),
            cartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            cartButton.widthAnchor.constraint(equalToConstant: 20),
            cartButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25),
            productImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            productImage.heightAnchor.constraint(equalToConstant: 200),
            productImage.heightAnchor.constraint(equalTo: productImage.widthAnchor, multiplier: 0.6),
        ])
        
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10),
            productName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            productName.trailingAnchor.constraint(equalTo: wishButton.leadingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 5),
            productPrice.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            wishButton.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10),
            wishButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            wishButton.widthAnchor.constraint(equalToConstant: 46),
            wishButton.heightAnchor.constraint(equalToConstant: 46)
        ])
        
        
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionText.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -90),
        ])
        
        NSLayoutConstraint.activate([
            buttonStack.heightAnchor.constraint(equalToConstant: 100),
            buttonStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            addToCartButton.heightAnchor.constraint(equalToConstant: 45),
            buyNowButton.heightAnchor.constraint(equalToConstant: 45),
        ])
        
    }
    
    @objc private func backTapped(){
        delegate?.tappedBackButton()
    }
    
    @objc private func cartTapped(){
        delegate?.tappedCartButton()
    }
    
    @objc private func wishTapped(){
        delegate?.tappedWishButton(!wished)
    }
    
    @objc private func addToCartTapped(){
        delegate?.tappedAddToCartButton()
    }
    
    @objc private func buyNowTapped(){
        delegate?.tappedBuyNowButton()
    }
}

// MARK: - DetailVCDelegate
extension DetailView: DetailVCDelegate{
    func updateWishButtonState(isWished: Bool) {
        let colorName = isWished ? Colors.greenPrimary : Colors.greyPrimary
        wishButton.tintColor = UIColor(named: colorName)
        wished = isWished
    }
}
