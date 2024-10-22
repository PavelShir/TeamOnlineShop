import UIKit
import Firebase

protocol SearchBarViewDelegate: AnyObject {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
}

final class SearchBarView: UIView {
    weak var delegate: SearchBarViewDelegate?
    var searchIcon: String = "magnifyingglass"
    var searchHistory = [String]()
    // MARK: - UI Properties
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        let image = UIImage(systemName: searchIcon)?.withTintColor(.clear, renderingMode: .alwaysOriginal)
        search.setImage(image, for: .search, state: .normal)
        search.delegate = self
        search.barTintColor = nil
        search.tintColor = UIColor(named: Colors.greyPrimary)
        search.searchTextPositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
        search.searchTextField.placeholder = "Search here"
        search.searchTextField.textColor = UIColor(named: Colors.greyLight)
        search.backgroundColor = UIColor(named: Colors.whitePrimary)
        return search
    }()

    private lazy var searchButton: UIButton = {
        let image = UIImage(systemName: searchIcon)
        let action = UIAction(image: image, handler: searchAction)
        let button = UIButton(type: .system, primaryAction: action)
        button.isEnabled = false
        return button
    }()
    
    private lazy var historyTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        return tableView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setupConstraints()
//        loadSearchHistory()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  Private Methods
    private func setView() {
        addSubview(searchBar)
        addSubview(historyTableView)
        searchBar.addSubview(searchButton)
        searchBar.backgroundImage = UIImage()
    }
    

    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        searchButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               searchButton.topAnchor.constraint(equalTo: searchBar.searchTextField.topAnchor, constant: 5),
               searchButton.leadingAnchor.constraint(equalTo: searchBar.searchTextField.leadingAnchor, constant: 5)
           ])

        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            historyTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            historyTableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    // MARK: - Private Methods
    private func searchAction(_ action: UIAction) {
        searchBarSearchButtonClicked(searchBar)
    }

    // MARK: - Internal Methods
    func toggleSearchButton(with value: Bool) {
        searchButton.isEnabled = value
    }
    
    func setSearchText(_ text: String) {
        searchBar.text = text
    }
}

extension SearchBarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        toggleSearchButton(with: !searchText.isEmpty)
        delegate?.searchBar(searchBar, textDidChange: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismiss(searchBar)
        delegate?.searchBarSearchButtonClicked(searchBar)
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        toggleSearchButton(with: !(searchBar.text?.isEmpty ?? true))
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        toggleSearchButton(with: false)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelAction(with: searchBar)
    }
}

// MARK: - Private Methods
extension SearchBarView {
    private func withAnimation(animatable: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5) {
            animatable()
        }
    }

    private func dismiss(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    private func cancelAction(with searchBar: UISearchBar) {
        withAnimation { [self] in
            searchBar.text = nil
            searchBar.showsCancelButton = false
            dismiss(searchBar)

            layoutIfNeeded()
        }
    }
}

extension SearchBarView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        cell.textLabel?.text = searchHistory[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.text = searchHistory[indexPath.row]
        searchBarSearchButtonClicked(searchBar)
    }
}
