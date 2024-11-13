//
//  HomeControllerViewModel.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 12/11/2024.
//
import UIKit

class HomeControllerViewModel {
    var onCoinsUpdate: (()-> Void)?
    var onErrorMessage: ((CoinErrorService)-> Void)?
    
   
    private(set) var allCoins: [Coin] = [] {
        // Called whenever the coin list is updated, except on initialization
        didSet {
            self.onCoinsUpdate?()
        }
    }
    
    private(set) var filteredCoins: [Coin] = [] {
        didSet {
            self.onCoinsUpdate?()
        }
    }
    
    init() {
        self.fetchCoins()
    }
    
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.allCoins = coins
            case .failure(let error):
                self?.onErrorMessage?(error)
                print("Error ViewModel: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Search functions
extension HomeControllerViewModel {
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredCoins = allCoins
        
        if let searchBarText = searchBarText?.lowercased() {
            guard !searchBarText.isEmpty else { self.onCoinsUpdate?(); return }
            self.filteredCoins = self.filteredCoins.filter({$0.name.lowercased().contains(searchBarText) })
        }
        
        self.onCoinsUpdate?()
    }
}
