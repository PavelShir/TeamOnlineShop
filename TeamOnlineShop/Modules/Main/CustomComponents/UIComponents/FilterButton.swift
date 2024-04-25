import UIKit

class CustomFiltersButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    
    private func commonInit() {
        setTitle(" Filters ", for: .normal)
        titleLabel?.font = UIFont.InterFont.Regular.size(of: 14)
        setImage(UIImage.Icons.filter2, for: .normal)
        tintColor = UIColor(named: Colors.blackLight)
        semanticContentAttribute = .forceRightToLeft
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Colors.greyBorders)?.cgColor
        layer.cornerRadius = 5
    }
}
