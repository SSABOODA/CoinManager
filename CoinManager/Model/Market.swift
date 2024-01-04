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
    
    func translateToDTO(
        tradePrice: Double,
        change: String
    ) -> MarketDTO {
        let marketWithPrice = MarketDTO(
            market: self.market,
            koreanName: self.koreanName,
            englishName: self.englishName,
            tradePrice: tradePrice,
            change: change
        )
        return marketWithPrice
    }
}

struct MarketDTO: Hashable {
    let id = UUID()
    
    let market: String
    let koreanName: String
    let englishName: String
    var tradePrice: Double
    var change: String
}


struct MarketTradePrice: Codable {
    let change: String
    let tradePrice: Double
    
    enum CodingKeys: String, CodingKey {
        case change
        case tradePrice = "trade_price"
    }
}


typealias TickerData = [MarketTradePrice]


