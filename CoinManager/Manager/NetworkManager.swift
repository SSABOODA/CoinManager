//
//  NetworkManager.swift
//  CoinManager
//
//  Created by 한성봉 on 1/3/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData<T: Decodable>(
        urlSting: String,
        type: T.Type,
        completionHandler: @escaping (T) -> Void
    ) {

        guard let url = URL(string: urlSting) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
//                    print("decodedData: \(decodedData)")
                    completionHandler(decodedData)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
