import UIKit
import AsyncImageView
import PlatziFakeStore

final class ProductsViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let reuseIdentifier = ProductsViewCell.description()
    
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
        element.font = UIFont.TextFont.Screens.MainScreen.categoryTitle
        element.tintColor = UIColor(named: Colors.blackLight)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let priceLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFont.Screens.ShopCartItem.title
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let addToCartButton: UIButton = {
        let element = UIButton(type: .system)

        element.setTitle("Add to cart", for: .normal)
        element.titleLabel?.font = UIFont.TextFont.Screens.ShopCartItem.price
        element.setTitleColor(.white, for: .normal)
        element.backgroundColor = UIColor(named: Colors.greenPrimary)
        element.layer.cornerRadius = 15
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
    }
    
    // MARK: - Global funcs
    func configure(model: PlatziFakeStore.Product) {
        productNameLabel.text = model.title
        priceLabel.text = "$\(model.price)"
        if let firstImageUrl = model.images.first {
               imageView.setImage(from: firstImageUrl)
           } else {
               imageView.image = UIImage(systemName: "photo")
           }
    }
    
    // MARK: - Private funcs
    private func setupView(){
        
        contentView.addSubviews(imageView,vStack)
        vStack.addArrangedSubviews(productNameLabel,priceLabel,addToCartButton)
        
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
            
            addToCartButton.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
}







