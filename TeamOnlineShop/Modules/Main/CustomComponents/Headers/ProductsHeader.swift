import UIKit

final class ProductsHeader: UICollectionReusableView {
    
    let label = UILabel()
    static let reuseIdentifier = ProductsHeader.description()
    
    private let filtersButton = CustomFiltersButton()
    
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
    
    func configure(delegate: CustomFiltersButtonDelegate?) {
         filtersButton.delegate = delegate
     }
    
    private func setupConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        filtersButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            filtersButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            filtersButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
