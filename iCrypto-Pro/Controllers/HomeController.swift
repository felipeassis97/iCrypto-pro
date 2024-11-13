//
//  ViewController.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 11/11/2024.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - Variables
    private let viewModel: HomeControllerViewModel
    
    // MARK: - UI Components
    private let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .systemBackground
        tv.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        return tv
    }()
    
    // MARK: - LyfeCycle
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchBarController()
        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel.onCoinsUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        self.viewModel.onErrorMessage = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                
                switch error {
                case .serverError(let error):
                    alert.title = "Server error \(error.errorCode)"
                    alert.message = error.errorMessage
                    
                case .decodingError(let message):
                    alert.title = "Error parsing data"
                    alert.message = message
                    
                case .unknownError(let message):
                    alert.title = "Error Fetching Coins"
                    alert.message = message
                    
                }
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.navigationItem.title = "iCrypto-Pro"
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setupSearchBarController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Cryptos"
        
        self.searchController.searchBar.showsBookmarkButton = true
        self.searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }
}

// MARK: - Search Controller functions
extension HomeController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
}

// MARK: - TableView Functions
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        return inSearchMode ? self.viewModel.filteredCoins.count : self.viewModel.allCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("Unable to dequeue CoinCell in HomeController")
        }
        
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        let currentCell = inSearchMode ? self.viewModel.filteredCoins[indexPath.row]: self.viewModel.allCoins[indexPath.row]
        cell.configure(with: currentCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        let currentCell = inSearchMode ? self.viewModel.filteredCoins[indexPath.row]: self.viewModel.allCoins[indexPath.row]
        
        let vm = CryptoControllerViewModel(currentCell)
        let vc = CryptoController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

