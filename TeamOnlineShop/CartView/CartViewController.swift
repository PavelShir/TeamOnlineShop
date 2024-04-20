//
//  CartViewController.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

import UIKit

class CartViewController: UIViewController {
    
    let itemCart: [CartModel] = Cart.allItems()
    
    //MARK: - Set Navigation Bar
    
    private lazy var backButton: UIBarButtonItem = {
        let element = UIBarButtonItem()
        element.image = .Icons.arrowLeft
        element.tintColor = .blackLight
        element.action = #selector(backButtonTapped)
        element.target = self
        return element
    }()
    
    private lazy var badgeCount: UILabel = {
        let element = UILabel(frame: CGRect(x: 22, y: -03, width: 14, height: 14))
        element.layer.borderColor = UIColor.clear.cgColor
        element.layer.borderWidth = 2
        element.layer.cornerRadius = element.bounds.size.height / 2
        element.textAlignment = .center
        element.layer.masksToBounds = true
        element.textColor = .white
        element.font = UIFont.TextFont.Element.TabBar.label
        element.backgroundColor = .redLight
        element.text = "3"
        return element
    }()

    private lazy var cartButton: UIButton = {
        let element = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
        element.setBackgroundImage(UIImage(systemName: "cart"), for: .normal)
        element.tintColor = .black
        element.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        element.addSubview(badgeCount)
        return element
    }()

    private lazy var cartButtonWithBadge: UIBarButtonItem = {
        let element = UIBarButtonItem(customView: cartButton)
        return element
    }()
    
    private func setNavigationBar() {
        title = "Your Cart"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = cartButtonWithBadge

    }
    
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
    
    private lazy var deliveryPicker: UIPickerView = {
        let element = UIPickerView()
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
    
    private lazy var amountLabel: UILabel = {
        let element = UILabel()
        element.text = "$ 2499,97"
        element.font = UIFont.TextFont.Screens.ShopCartItem.title
        element.tintColor = .blackLight
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var payButton: UIButton = {
        let element = UIButton()
        element.setTitle("Pay", for: .normal)
        element.titleLabel?.font = UIFont.TextFont.Element.Button.normal
        element.tintColor = UIColor(named: Colors.whitePrimary)
        element.backgroundColor = .greenPrimary
        element.layer.cornerRadius = 4
        element.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - UI Collection View
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 350, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: "CartCell")
        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
//        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = false
        return collectionView
    }()
    
    
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
        
        view.addSubview(line)
        view.addSubview(deliveryStack)
        
        deliveryStack.addArrangedSubview(deliveryLabel)
        deliveryStack.addArrangedSubview(deliveryPicker)
        
        view.addSubview(lineTwo)
        
        view.addSubview(collectionView)
        
        view.addSubview(lineThree)
        view.addSubview(orderLabel)
        view.addSubview(totalsStack)
        
        totalsStack.addArrangedSubview(totalsLabel)
        totalsStack.addArrangedSubview(amountLabel)
        
        view.addSubview(payButton)
    }
    
    //MARK: - Button Tapped
    
    @objc private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func cartButtonTapped() {
    }
    
    @objc private func checkButtonTapped() {
        
    }
    
    @objc private func minusButtonTapped() {
    }
    
    @objc private func plusButtonTapped() {
    }
    
    @objc private func trashButtonTapped() {
    }
    
    @objc private func payButtonTapped() {
        let payVC = PaymentsViewController()
        present(payVC, animated: true)
    }
    
}

//MARK: - Setup Constraints

extension CartViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            line.heightAnchor.constraint(equalToConstant: 1),
            line.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            line.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            deliveryStack.heightAnchor.constraint(equalToConstant: 50),
            deliveryStack.topAnchor.constraint(equalTo: line.bottomAnchor),
            deliveryStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            deliveryStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            lineTwo.heightAnchor.constraint(equalToConstant: 1),
            lineTwo.topAnchor.constraint(equalTo: deliveryStack.bottomAnchor),
            lineTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: lineTwo.bottomAnchor,constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -160),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            lineThree.heightAnchor.constraint(equalToConstant: 1),
            lineThree.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -160),
            lineThree.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineThree.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            orderLabel.bottomAnchor.constraint(equalTo: totalsStack.topAnchor, constant: -1),
            orderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            orderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            orderLabel.heightAnchor.constraint(equalToConstant: 30),
            
            totalsStack.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -10),
            totalsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            totalsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            totalsStack.heightAnchor.constraint(equalToConstant: 30),
            
            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            payButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}

//MARK: - Delegate

extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(itemCart.count)
        return itemCart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.setup(Cart.allItems()[indexPath.item])
        return cell
    }
    
    
}
