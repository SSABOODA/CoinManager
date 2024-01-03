//
//  CoinListViewModel.swift
//  CoinManager
//
//  Created by 한성봉 on 1/2/24.
//

import Foundation

final class CoinListViewModel: ObservableObject {
    
    @Published var market: [Market] = [
//        Market(market: "1", koreanName: "1번", englishName: "num 1"),
//        Market(market: "2", koreanName: "2번", englishName: "num 2"),
//        Market(market: "3", koreanName: "3번", englishName: "num 3")
    ]
    
    @Published var filterMarket: [Market]? = []
    
    init() {
        self.fetchAllMarket()
        self.filterMarket = market
    }
    
    func fetchAllMarket() {
        guard let url = URL(string: URLs.upbitCoinListURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                DispatchQueue.main.async {
                    self?.market = decodedData
                    self?.filterMarket = self?.market
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
