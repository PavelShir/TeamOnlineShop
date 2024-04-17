import UIKit

class ProductsViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static var reuseIdentifier: String {"\(Self.self)"}
    
    // MARK: - UI
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "CellImage")
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        element.tintColor = UIColor(named: Colors.blackLight)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var productNameLabel: UILabel = {
        let element = UILabel()
        element.text = "Monitor LG 22”inc 4K 120Fps"
        element.numberOfLines = 1
        element.font = UIFont.TextFont.Screens.MainScreen.categoryTitle
        element.tintColor = UIColor(named: Colors.blackLight)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.text = "$199.99"
        element.font = UIFont.TextFont.Screens.ShopCartItem.title
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var addToCartButton: UIButton = {
        let element = UIButton(type: .system)

        element.setTitle("Add to cart", for: .normal)
        element.titleLabel?.font = UIFont.TextFont.Screens.ShopCartItem.price
        element.setTitleColor(.white, for: .normal)
        element.backgroundColor = UIColor(named: Colors.greenPrimary)
        element.layer.cornerRadius = 4
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var VStack: UIStackView = {
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
    
    // MARK: - Private funcs
    private func setupView(){
        
        contentView.addSubview(imageView)
        contentView.addSubview(VStack)
        
        [productNameLabel,
         priceLabel,
         addToCartButton
        ].forEach { VStack.addArrangedSubview($0)}
        
        contentView.backgroundColor = UIColor(named: "white-primary")
        contentView.layer.cornerRadius = 15
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            VStack.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: 2
            ),
            VStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -13
            ),
            VStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 13),
            VStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -13
            ),
            
            addToCartButton.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
}







