//
//  DetailViewController.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 16.04.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    //Временные значения
    let imageName = "airPodsMaximage"
    let name = "Air pods max by Apple"
    let price = "$ 1999,99"
    let nameDescription = "Description of product"
    let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquet arcu id tincidunt tellus arcu rhoncus, turpis nisl sed. Neque viverra ipsum orci, morbi semper. Nulla bibendum purus tempor semper purus. Ut curabitur platea sed blandit. Amet non at proin justo nulla et. A, blandit morbi suspendisse vel malesuada purus massa mi. Faucibus neque a mi hendrerit.\n \n Audio Technology \n Apple-designed dynamic driver \n Active Noise Cancellation \n Transparency mode"
    
    //MARK: - Set Navigation Bar
    
    private lazy var backButton: UIBarButtonItem = {
        let element = UIBarButtonItem()
        element.image = .Icons.arrowLeft
        element.tintColor = .blackLight
        element.action = #selector(backButtonTapped)
        element.target = self
        return element
    }()
    
    private lazy var cartButton: UIBarButtonItem = {
        let element = UIBarButtonItem()
        element.image = .Icons.cart
        element.tintColor = .blackLight
        element.action = #selector(cartButtonTapped)
        return element
    }()
    
    private lazy var countCart: UILabel = {
        let element = UILabel()

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private func setNavigationBar() {
        title = "Details product"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = cartButton

    }
    
    //MARK: - UI - Scroll View
    
    private lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.showsVerticalScrollIndicator = false
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var contentView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - UI

    private lazy var viewForImage: UIView = {
        let element = UIView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: imageName)
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .equalSpacing
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var verticalStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.text = name
        element.font = UIFont.InterFont.Regular.size(of: 16)
        element.tintColor = UIColor(named: Colors.blackLight)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.text = price
        element.font = UIFont.InterFont.Regular.size(of: 18)
        element.tintColor = UIColor(named: Colors.blackLight)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var wishListButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage.Icons.wishlist, for: .normal)
        element.tintColor = UIColor(named: Colors.greyPrimary)
        element.backgroundColor = UIColor(named: Colors.greyLightest)
        element.layer.cornerRadius = 23
        element.addTarget(self, action: #selector(wishListButtonTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var nameDescriptionLabel: UILabel = {
        let element = UILabel()
        element.text = nameDescription
        element.font = UIFont.InterFont.Regular.size(of: 16)
        element.tintColor = UIColor(named: Colors.blackLight)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.text = text
        element.numberOfLines = 0
        element.font = UIFont.InterFont.Regular.size(of: 12)
        element.tintColor = UIColor(named: Colors.blackLight)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var buttonStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fillEqually
        element.alignment = .center
        element.spacing = 15
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var line: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(named: Colors.greyLightest)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var addToCartButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Add to Cart", for: .normal)
        element.titleLabel?.font = UIFont.InterFont.Regular.size(of: 14)
        element.tintColor = UIColor(named: Colors.whitePrimary)
        element.backgroundColor = .greenPrimary
        element.layer.cornerRadius = 4
        element.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var buyNowButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Buy Now", for: .normal)
        element.titleLabel?.font = UIFont.InterFont.Regular.size(of: 14)
        element.tintColor = UIColor(named: Colors.blackLight)
        element.tintColor = .black
        element.backgroundColor = UIColor(named: Colors.greyLighter)
        element.layer.cornerRadius = 4
        element.addTarget(self, action: #selector(buyNowButtonTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let emptyView = UIView()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setViews()
        setupConstraints()
    }
    
    //MARK: - Set Views
    
    private func setViews() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        contentView.addSubview(viewForImage)
        viewForImage.addSubview(imageView)

        contentView.addSubview(horizontalStack)
        
        horizontalStack.addArrangedSubview(verticalStack)
        horizontalStack.addArrangedSubview(wishListButton)
        
        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(priceLabel)
        
        contentView.addSubview(nameDescriptionLabel)
        contentView.addSubview(descriptionLabel)
        
        contentView.addSubview(emptyView)
        
        view.addSubview(line)
        view.addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(addToCartButton)
        buttonStack.addArrangedSubview(buyNowButton)
    }
    
    //MARK: - Button Tapped
    
    @objc private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    @objc private func cartButtonTapped() {
    }
    
    @objc private func wishListButtonTapped() {
    }
    
    @objc private func addToCartButtonTapped() {
    }
    
    @objc private func buyNowButtonTapped() {
    }

}

//MARK: - Setup Constraints

extension DetailViewController {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            viewForImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewForImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewForImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: viewForImage.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: viewForImage.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: viewForImage.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: viewForImage.widthAnchor, multiplier: 1),

            horizontalStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 9),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            horizontalStack.heightAnchor.constraint(equalToConstant: 47),
            
            wishListButton.heightAnchor.constraint(equalToConstant: 46),
            wishListButton.widthAnchor.constraint(equalToConstant: 46),
            
            nameDescriptionLabel.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 15),
            nameDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameDescriptionLabel.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            line.heightAnchor.constraint(equalToConstant: 1),
            line.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            line.topAnchor.constraint(equalTo: buttonStack.topAnchor),
            
            buttonStack.heightAnchor.constraint(equalToConstant: 100),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            addToCartButton.heightAnchor.constraint(equalToConstant: 45),
            buyNowButton.heightAnchor.constraint(equalToConstant: 45),
        ])
        
    }
}
