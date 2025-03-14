import UIKit

class CountriesViewController: UIViewController {
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var allCountries: [Country] = []
    private var filteredCountries: [Country] = []
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        setupTableView()
        setupSearchController()
        fetchCountries()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        // Support for Dynamic Type
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by name or capital"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func fetchCountries() {
        NetworkService.shared.fetchCountries { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self.allCountries = countries
                    self.tableView.reloadData()
                case .failure(let error):
                    self.showAlert(with: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    private func filterContent(for searchText: String) {
        filteredCountries = allCountries.filter { country in
            return country.name.lowercased().contains(searchText.lowercased()) ||
                   country.capital.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    private func showAlert(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCountries.count : allCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        let country = isFiltering ? filteredCountries[indexPath.row] : allCountries[indexPath.row]
        cell.configure(with: country)
        return cell
    }
}

extension CountriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let searchText = searchBar.text {
            filterContent(for: searchText)
        }
    }
}