import UIKit

protocol CategoryHeaderDelegate: AnyObject {
    func searchBarTextDidChange(_ searchBar: UISearchBar, newText: String)
    func searchBarSearchButtonClicked(with text: String)
    func tappedCartButton()
    func getItemsCount() -> Int
}

final class CategoryHeader: UICollectionReusableView, UISearchBarDelegate, SearchBarViewDelegate {
    
    weak var delegate: CategoryHeaderDelegate?
    
    //MARK: Properties
    static let reuseIdentifier = CategoryHeader.description()
    
    private let searchBar = SearchBarView()
    private let DeliveryTitle: UILabel = {
        let label = UILabel()
        label.text = "Delivery address"
        label.font = UIFont.TextFont.Element.Location.label
        label.textColor = UIColor(named:Colors.greyLight)
        return label
    }()
    
    private let addressLabel = AddressSelector()
    
    private let bellButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setBackgroundImage(UIImage.Icons.bell, for: .normal)
        button.tintColor = UIColor(named: Colors.blackLight)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cartButton = CustomCartButton()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func configure() {
        delegate
            .map { $0.getItemsCount() }
            .map(cartButton.setItemCount)
    }
    
    // MARK: - Funcs
    private func setViews() {
        addSubviews(addressLabel,
                    DeliveryTitle,
                    cartButton,
                    bellButton,
                    searchBar)
        
        bellButton.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        DeliveryTitle.translatesAutoresizingMaskIntoConstraints = false
        bellButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            DeliveryTitle.topAnchor.constraint(equalTo: topAnchor),
            DeliveryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            DeliveryTitle.trailingAnchor.constraint(lessThanOrEqualTo: bellButton.leadingAnchor, constant: -8),
            DeliveryTitle.heightAnchor.constraint(equalToConstant: 15),

            addressLabel.topAnchor.constraint(equalTo: DeliveryTitle.bottomAnchor, constant: 1),
            addressLabel.leadingAnchor.constraint(equalTo: DeliveryTitle.leadingAnchor),
            addressLabel.trailingAnchor.constraint(lessThanOrEqualTo: bellButton.leadingAnchor, constant: -8),

            bellButton.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor),
            bellButton.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: -16),
            bellButton.heightAnchor.constraint(equalToConstant: 25),
            bellButton.widthAnchor.constraint(equalToConstant: 25),
            
            cartButton.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor),
            cartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cartButton.heightAnchor.constraint(equalToConstant: 25),
            cartButton.widthAnchor.constraint(equalToConstant: 25),

            searchBar.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 15),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        cartButton.addTarget(nil, action: #selector(cartTapped), for: .touchUpInside)
    }
    
    @objc private func cartTapped(){
        delegate?.tappedCartButton()
    }
    
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // здесь можно добавить функционал для поведения при вводе текста в сёрч
        
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        //        print("text changed now")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            delegate?.searchBarSearchButtonClicked(with: searchText)
        }
    }
}

