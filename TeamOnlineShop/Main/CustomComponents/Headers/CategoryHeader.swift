import UIKit

protocol CategoryHeaderDelegate {
    func searchBarTextDidChange(_ searchBar: UISearchBar, newText: String)
    func searchBarSearchButtonClicked(with text: String)
}

final class CategoryHeader: UICollectionReusableView, UISearchBarDelegate, SearchBarViewDelegate {

    var delegate: CategoryHeaderDelegate?

    //MARK: -> Properties
    static let reuseIdentifier = CategoryHeader.description()


    private let searchBar = SearchBarView()
    
    private let DeliveryTitle: UILabel = {
        let label = UILabel()
        label.text = "Salatiga City, Central Java"
        label.font = UIFont.TextFont.Element.Location.label
        label.tintColor = UIColor(named:Colors.greyLight)
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery address: Salatiga City, Central Java"
        label.font = UIFont.TextFont.Element.Location.address
        label.tintColor = UIColor(named:Colors.blackLight)
        return label
    }()
    
    private let bellIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.Icons.bell)
          imageView.contentMode = .scaleAspectFit
          return imageView
      }()
    
    private let cartIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.Icons.cart)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()

    //MARK: -> init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -> Function
    private func setViews() {
        addSubviews(addressLabel,
                    DeliveryTitle,
                    cartIconImageView,
                    bellIconImageView,
                    searchBar)
        
        bellIconImageView.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        DeliveryTitle.translatesAutoresizingMaskIntoConstraints = false
        bellIconImageView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        cartIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            DeliveryTitle.topAnchor.constraint(equalTo: topAnchor),
            DeliveryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            DeliveryTitle.trailingAnchor.constraint(lessThanOrEqualTo: bellIconImageView.leadingAnchor, constant: -8),
            DeliveryTitle.heightAnchor.constraint(equalToConstant: 15),
            
            addressLabel.topAnchor.constraint(equalTo: DeliveryTitle.bottomAnchor, constant: 1),
            addressLabel.leadingAnchor.constraint(equalTo: DeliveryTitle.leadingAnchor),
            addressLabel.trailingAnchor.constraint(lessThanOrEqualTo: bellIconImageView.leadingAnchor, constant: -8),
            
            bellIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            bellIconImageView.trailingAnchor.constraint(equalTo: cartIconImageView.leadingAnchor, constant: -16),
            bellIconImageView.heightAnchor.constraint(equalToConstant: 28),
            bellIconImageView.widthAnchor.constraint(equalToConstant: 28),
            
            cartIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cartIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cartIconImageView.heightAnchor.constraint(equalToConstant: 28),
            cartIconImageView.widthAnchor.constraint(equalToConstant: 28),
            
            searchBar.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 15),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
