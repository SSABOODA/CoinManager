//
//  MainViewModel.swift
//  CoinManager
//
//  Created by 한성봉 on 1/3/24.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var markets: [Market] = []
    
    func fetchAllMarket() {
        guard let url = URL(string: URLs.upbitCoinListURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(
                    [Market].self,
                    from: data
                )
                DispatchQueue.main.async {
                    self?.markets = decodedData
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
