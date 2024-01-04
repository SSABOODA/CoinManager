//
//  CoinAskingPriceViewModel.swift
//  CoinManager
//
//  Created by 한성봉 on 1/3/24.
//

import Foundation
import Combine

final class CoinAskingPriceViewModel: ObservableObject {
    var marketData: MarketDTO
    
    @Published var askOrderBook: [OrderBookItem] = []
    @Published var bidOrderBook: [OrderBookItem] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    init(market: Market) {
        
        let marketDTO = market.translateToDTO(tradePrice: 0, change: "")
        self.marketData = marketDTO
        
        WebSocketManager.shared.openWebSocket()
        WebSocketManager.shared.send(marketData.market)

        WebSocketManager.shared.orderBookSbj
            .receive(on: DispatchQueue.main)
            .sink { [weak self] order in
                guard let self else { return }
                
                self.askOrderBook = order.orderbookUnits
                    .map { .init(price: $0.askPrice, size: $0.askSize)}
                    .sorted { $0.price > $1.price }
                
                self.bidOrderBook = order.orderbookUnits
                    .map { .init(price: $0.bidPrice, size: $0.bidSize)}
                    .sorted { $0.price > $1.price }
            }
            .store(in: &cancellable)
        
        self.fetchTickerInfo()
    }
    
    deinit {
        WebSocketManager.shared.closeWebSocket()
    }
    
    func largestAskSize() -> Double {
        let data = askOrderBook.sorted(by: { $0.size > $1.size })
        return data.first?.size ?? 0
    }
    
    func largestBidSize() -> Double {
        let data = bidOrderBook.sorted(by: { $0.size > $1.size })
        return data.first?.size ?? 0
    }
    
    func fetchTickerInfo() {
        let urlString = "https://api.upbit.com/v1/ticker?markets=\(self.marketData.market)"
        NetworkManager.shared.fetchData(
            urlSting: urlString,
            type: TickerData.self) { [weak self] data in
                guard let ticker = data.first else { return }
                self?.marketData.change = ticker.change
                self?.marketData.tradePrice = ticker.tradePrice
            }
    }
}
