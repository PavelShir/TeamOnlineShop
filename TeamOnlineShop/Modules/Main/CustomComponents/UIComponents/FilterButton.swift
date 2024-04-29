import UIKit

protocol CustomFiltersButtonDelegate: AnyObject {
    func filterByName()
    func filterByPriceRange(low: Double, high: Double)
    func filterByPrice()
}

class CustomFiltersButton: UIButton {

    weak var delegate: CustomFiltersButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func commonInit() {
        
        var config = UIButton.Configuration.plain()

        config.image = UIImage.Icons.filter2
        config.imagePlacement = .trailing
        config.imagePadding = 10
        
        configuration = config
        
        setTitle("Filters", for: .normal)
        titleLabel?.font = UIFont.InterFont.Regular.size(of: 14)
        tintColor = UIColor(named: Colors.blackLight)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Colors.greyBorders)?.cgColor
        layer.cornerRadius = 5
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        let menu = configureMenu()
        self.menu = menu
        self.showsMenuAsPrimaryAction = true
    }
    
    private func configureMenu() -> UIMenu {
        
        let sortByName = UIAction(title: "Sort by Name") { [weak self] _ in
               self?.delegate?.filterByName()
           }
        
         let sortByPrice = UIAction(title: "Sort by Price") { [weak self] _ in
               self?.delegate?.filterByPrice()
           }
        
        let priceSubMenu = createPriceSubMenu()
        
        let menu = UIMenu(title: "", children: [sortByName,sortByPrice, priceSubMenu])
        return menu
    }
    
    private func createPriceSubMenu() -> UIMenu {
         let lowPrice = UIAction(title: "Under $50") { _ in
             self.delegate?.filterByPriceRange(low: 0, high: 50)
         }
         let midPrice = UIAction(title: "$50 to $100") { _ in
             self.delegate?.filterByPriceRange(low: 50, high: 100)
         }
         let highPrice = UIAction(title: "Over $100") { _ in
             self.delegate?.filterByPriceRange(low: 100, high: 999999)
         }

         let priceMenu = UIMenu(title: "Price Range", children: [lowPrice, midPrice, highPrice])
         return priceMenu
     
    }
    
    @objc func buttonPressed() {
        print("tap")
    }
}

