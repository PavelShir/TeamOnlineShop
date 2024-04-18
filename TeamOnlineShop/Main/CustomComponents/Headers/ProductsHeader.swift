import UIKit

final class ProductsHeader: UICollectionReusableView {
    let label = UILabel()
    static let reuseIdentifier = ProductsHeader.description()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "Categories"
        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
