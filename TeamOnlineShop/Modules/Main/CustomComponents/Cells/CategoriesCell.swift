import UIKit

final class CategoriesViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = CategoriesViewCell.description()
    
    // MARK: - UI
    private let iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Colors.greenPrimary)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.Icons.allCategories
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let categoryNameLabel: UILabel = {
        let element = UILabel()
        element.text = "Сategory"
        element.font = UIFont.TextFont.Screens.MainScreen.categoryTitle
        element.textColor = UIColor(named: Colors.greyPrimary)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        contentView.addSubview(vStack)
        iconBackgroundView.addSubview(imageView)
        vStack.addArrangedSubviews(iconBackgroundView,categoryNameLabel)
        contentView.backgroundColor = UIColor(named: Colors.whitePrimary)
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            iconBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: 40),
            
            imageView.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            vStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            vStack.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            vStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
