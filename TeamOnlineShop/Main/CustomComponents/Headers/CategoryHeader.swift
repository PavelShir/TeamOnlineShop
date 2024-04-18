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
    
    private let deliveryAddressLabel: UILabel = {
          let label = UILabel()
          label.text = "Delivery address: Salatiga City, Central Java"
          label.font = UIFont.systemFont(ofSize: 14)
          return label
      }()
    
    private let subtitleLabel: UILabel = {
          let label = UILabel()
          label.text = "Salatiga City, Central Java"
          label.font = UIFont.systemFont(ofSize: 14)
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
        addSubviews(deliveryAddressLabel,
                    subtitleLabel,
                    cartIconImageView,
                    bellIconImageView,
                    searchBar)
        
        bellIconImageView.translatesAutoresizingMaskIntoConstraints = false
        deliveryAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bellIconImageView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        cartIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deliveryAddressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            deliveryAddressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            deliveryAddressLabel.trailingAnchor.constraint(lessThanOrEqualTo: bellIconImageView.leadingAnchor, constant: -8),
            
            deliveryAddressLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: bellIconImageView.leadingAnchor, constant: -8),
            
            cartIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cartIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cartIconImageView.heightAnchor.constraint(equalToConstant: 24),
            cartIconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            bellIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            bellIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bellIconImageView.heightAnchor.constraint(equalToConstant: 24), // Размер можно изменить по необходимости
            bellIconImageView.widthAnchor.constraint(equalToConstant: 24), // Размер можно изменить по необходимости
            
            searchBar.topAnchor.constraint(equalTo: deliveryAddressLabel.bottomAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor) // Последний элемент, который прижимаем к низу хедера
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
