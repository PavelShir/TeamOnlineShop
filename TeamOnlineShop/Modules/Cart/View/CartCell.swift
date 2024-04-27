//
//  CartCell.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

import UIKit

final class CartCell: UICollectionViewCell {
    static let identifier = CartCell.debugDescription()
    
    override var isSelected: Bool {
        didSet { updateCheckmark(isSelected) }
    }
    
    private var minusAction: (() -> Void)?
    private var plusAction: (() -> Void)?
    private var trashAction: (() -> Void)?
            
    private lazy var checkButton: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: self.isSelected ? "checkmark.square.fill" : "square")
        element.tintColor = isSelected ? .greenPrimary : .lightGray
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var cellStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 10
        element.backgroundColor = .white
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
    
    private lazy var numberLabel: UILabel = {
        let element = UILabel()
        element.tintColor = .blackLight
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
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupConstraints()
        
        minusButton.addTarget(self, action: #selector(self.minus), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(self.plus), for: .touchUpInside)
        trashButton.addTarget(self, action: #selector(self.trash), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        numberLabel.text = nil
        
        minusAction = nil
        plusAction = nil
        trashAction = nil
    }
    
    //MARK: - Public methods
    func setup(_ item: CartItemCell) {
        imageView.image = UIImage(named: "CellImage")
        titleLabel.text = item.title
        priceLabel.text = "$ ".appending(item.price.description)
        numberLabel.text = item.count.description
        
        minusAction = item.decreaseCounter
        plusAction = item.increaseCounter
        trashAction = item.deleteItem
    }
    
}

private extension CartCell {
    @objc func minus() {
        minusAction?()
    }
    
    @objc func plus() {
        plusAction?()
    }
    
    @objc func trash() {
        trashAction?()
    }
    
    func updateCheckmark(_ isSelected: Bool) {
        checkButton.image = UIImage(systemName: isSelected ? "checkmark.square.fill" : "square")
        checkButton.tintColor = isSelected ? .greenPrimary : .systemGray
    }
    
    func setupContentView() {
        contentView.addSubview(cellStack)
        clipsToBounds = true
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
    }
    
    func setupConstraints() {
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
