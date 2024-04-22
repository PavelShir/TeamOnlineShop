import UIKit

final class ProductsHeader: UICollectionReusableView {
    
    let label = UILabel()
    static let reuseIdentifier = ProductsHeader.description()
    
    private let filtersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Filters ", for: .normal)
        button.titleLabel?.font = UIFont.InterFont.Regular.size(of: 14)
        button.setImage(UIImage.Icons.filter2, for: .normal)
        button.tintColor = UIColor(named: Colors.blackLight)
        button.semanticContentAttribute = .forceRightToLeft
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: Colors.greyBorders)?.cgColor
        button.layer.cornerRadius = 5
        return button
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        label.text = "Products"
        addSubviews(label,filtersButton)
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        filtersButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            filtersButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            filtersButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            filtersButton.heightAnchor.constraint(equalTo: label.heightAnchor),
            filtersButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
