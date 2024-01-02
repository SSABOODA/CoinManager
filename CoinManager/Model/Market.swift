//
//  Market.swift
//  CoinManager
//
//  Created by 한성봉 on 1/2/24.
//

import Foundation

struct Market: Codable, Hashable {
    let id = UUID()
    
    let market: String
    let koreanName: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case market = "market"
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
