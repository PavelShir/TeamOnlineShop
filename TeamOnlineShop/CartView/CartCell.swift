//
//  CartCell.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

import UIKit

class CartCell: UICollectionViewCell {
    
    private lazy var cellStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 10
//        element.distribution = .equalSpacing
        element.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var checkButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal) // пустой "square"
        element.tintColor = .greenPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.layer.cornerRadius = 5
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var detailsStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .equalSpacing
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFont.Screens.ShopCartItem.title
        element.tintColor = .blackLight
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFont.Screens.ShopCartItem.price
        element.tintColor = .blackLight
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var buttonStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 5
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var minusButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage.Icons.minus, for: .normal)
        element.tintColor = .greyLight
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var numberLabel: UILabel = {
        let element = UILabel()
        element.tintColor = .blackLight
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var plusButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage.Icons.plus, for: .normal)
        element.tintColor = .greyLight
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var trashButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage.Icons.trashCircle, for: .normal)
        element.tintColor = .greyLight
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    func setup(_ item: CartModel) {
        
        imageView.image = UIImage(named: "CellImage")
        titleLabel.text = item.title
        priceLabel.text = "$ " + String(item.price)
        numberLabel.text = String(item.amount)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        self.contentView.addSubview(cellStack)
        cellStack.addArrangedSubview(checkButton)
        cellStack.addArrangedSubview(imageView)
        cellStack.addArrangedSubview(detailsStack)

        detailsStack.addArrangedSubview(titleLabel)
        detailsStack.addArrangedSubview(priceLabel)
        
        
        detailsStack.addSubview(buttonStack)
        buttonStack.addArrangedSubview(minusButton)
        buttonStack.addArrangedSubview(numberLabel)
        buttonStack.addArrangedSubview(plusButton)
        buttonStack.addArrangedSubview(trashButton)
        
        self.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            
            cellStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellStack.heightAnchor.constraint(equalToConstant: 80),
            
            checkButton.heightAnchor.constraint(equalToConstant: 25),
            checkButton.widthAnchor.constraint(equalToConstant: 25),
            
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            
            detailsStack.topAnchor.constraint(equalTo: cellStack.topAnchor, constant: 5),
            detailsStack.bottomAnchor.constraint(equalTo: cellStack.bottomAnchor, constant: -5),
            
            buttonStack.bottomAnchor.constraint(equalTo: cellStack.bottomAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
}
