//
//  CoinListViewModel.swift
//  CoinManager
//
//  Created by 한성봉 on 1/2/24.
//

import Foundation

final class CoinListViewModel: ObservableObject {
    
    @Published var market: [Market] = []
    @Published var filterMarket: [Market] = []
    @Published var marketDTO: [MarketDTO] = []
    @Published var filterMarketDTO: [MarketDTO] = []
    
    init() {
//        self.fetchAllMarket()
//        self.filterMarket = market
    }
    
    func fetchAllMarket() {
        NetworkManager.shared.fetchData(
            urlSting: URLs.upbitCoinListURL,
            type: [Market].self) { [weak self] data in
                self?.market = data
                self?.filterMarket = self?.market ?? []
            }
    }
}
