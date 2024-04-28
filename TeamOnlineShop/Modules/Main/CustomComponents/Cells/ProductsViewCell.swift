import UIKit
import AsyncImageView
import PlatziFakeStore

protocol ProductsViewCellDelegate: AnyObject {
    func didTapAddToCartButton(productId id: Int)
    func didTapWishButton(productId id: Int )
}

final class ProductsViewCell: UICollectionViewCell {
    // MARK: - Properties
    weak var delegate: ProductsViewCellDelegate?
    static let reuseIdentifier = ProductsViewCell.description()
    
    private var productId: Int?
    
    // MARK: - UI
    private var imageView: AsyncImageView = {
        let imageView = AsyncImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(named: Colors.blackLight)
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 1
        element.font = UIFont.TextFont.Screens.ShopCartItem.title
        element.tintColor = UIColor(named: Colors.blackLight)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let priceLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFont.Screens.ShopCartItem.price
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let addToCartButton = CustomButton(label: "Add to cart", size: CustomButton.Size.normal, type: CustomButton.ButtonType.primary)
    
    private var wishButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 23
        button.setBackgroundImage(UIImage.Icons.wishlist, for: .normal)
        button.tintColor = UIColor(named: Colors.greenPrimary)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var hStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fill
        element.alignment = .center
        element.spacing = 15
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let vStack: UIStackView = {
        let element = UIStackView()
        
        element.axis = .vertical
        element.spacing = 13
        element.alignment = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(named: Colors.whiteCell)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.prepareForReuse()
        productNameLabel.text = nil
        priceLabel.text = nil
        productId = nil
    }
    
    // MARK: - Global funcs
    func configure(model: Product,  showLikeButton: Bool) {
        productNameLabel.text = model.title
        priceLabel.text = "$\(model.price)"
        wishButton.isHidden = !showLikeButton
        productId = model.id
        
        if let firstImageUrl = model.images.first {
            imageView.setImage(from: firstImageUrl)
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
    }
    
    // MARK: - Private funcs
    private func setupView(){
        hStack.addArrangedSubviews(wishButton, addToCartButton)
        contentView.addSubviews(imageView,vStack)
        vStack.addArrangedSubviews(productNameLabel,priceLabel,hStack)
        
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        wishButton.addTarget(self, action: #selector(wishButtonTapped), for: .touchUpInside)
    }

    @objc private func addToCartButtonTapped() {
        delegate?.didTapAddToCartButton(productId: productId!)
    }

    @objc private func wishButtonTapped() {
        delegate?.didTapWishButton(productId: productId!)
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            vStack.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: 13
            ),
            vStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -13
            ),
            vStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 13),
            vStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -13
            ),
            
            addToCartButton.heightAnchor.constraint(equalToConstant: 30),
            wishButton.heightAnchor.constraint(equalToConstant: 25),
            wishButton.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}
