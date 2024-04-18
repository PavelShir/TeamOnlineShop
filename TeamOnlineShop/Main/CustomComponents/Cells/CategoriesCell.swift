import UIKit

final class CategoriesViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = CategoriesViewCell.description()
    
    // MARK: - UI
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "qNOjJje")
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var categoryNameLabel: UILabel = {
        let element = UILabel()
        element.text = "Category"
        element.font = UIFont.TextFont.Screens.MainScreen.categoryTitle
        element.textColor = UIColor(named: "grey-primary")
        element.backgroundColor = .green
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
        contentView.addSubview(categoryNameLabel)
   
        contentView.backgroundColor = UIColor(named: "white-primary")
        contentView.layer.cornerRadius = 15
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            
            categoryNameLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: 3),
            categoryNameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 5),
            categoryNameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -5),
            categoryNameLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: contentView.bottomAnchor, constant: -2),
        ])
    }
}

