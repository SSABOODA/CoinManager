//
//  CoinAskingPriceView.swift
//  CoinManager
//
//  Created by 한성봉 on 1/3/24.
//

import SwiftUI

struct CoinAskingPriceView: View {
    
    @StateObject var viewModel = CoinAskingPriceViewModel(
        market: Market(
            market: "KRW-BTC",
            koreanName: "비트코인",
            englishName: "num 1"
        )
    )
    
    var body: some View {
        ScrollView {

            GeometryReader { proxy in
                
                let graphWidth = proxy.size.width * 0.3
                
                VStack(alignment: .center) {
                    // 1. ask
                    ForEach(viewModel.askOrderBook, id: \.self) { item in
                        
                        HStack(alignment: .center) {
                            // 1.
                            ZStack(alignment: .trailing) {
                                let graphSize = CGFloat(item.size) / CGFloat(viewModel.largestAskSize()) * graphWidth
                                
                                Rectangle()
                                    .foregroundColor(Color(hexString: ConstantColor.blueGraphColor.hexCode))
                                    .frame(maxWidth: graphSize, alignment: .trailing)
                                    .frame(height: 20)
                                
                                Text("\(item.size)")
                                    .frame(width: graphWidth)
                                
                            }
                            .frame(maxWidth: graphWidth)
                            .frame(height: 40)
                            .background(Color(hexString: ConstantColor.blueBackgroundColor.hexCode))
                            
                            // 2.
                            Text("\(item.price.formatted())")
                                .frame(width: proxy.size.width * 0.3)
                                .frame(height: 40)
                                .foregroundStyle(Color(hexString: ConstantColor.blueTextColor.hexCode))
                                .background(Color(hexString: ConstantColor.blueBackgroundColor.hexCode))
                            
                            // 3.
                            Spacer()
                                .frame(width: proxy.size.width * 0.3)
                        }
                        .frame(height: 40)
                        
                    }
                    
                    // 2. bid
                    ForEach(viewModel.bidOrderBook, id: \.self) { item in
                        
                        HStack(alignment: .center) {
                            // 1.
                            Spacer()
                                .frame(width: proxy.size.width * 0.35)
                            
                            // 2.
                            Text("\(item.price.formatted())")
                                .frame(width: proxy.size.width * 0.3)
                                .frame(height: 40)
                                .foregroundStyle(Color(hexString: ConstantColor.blueTextColor.hexCode))
                                .background(Color(hexString: ConstantColor.redBackgroundColor.hexCode))
                            
                            // 3.
                            ZStack(alignment: .leading) {
                                
                                let graphSize = CGFloat(item.size) / CGFloat(viewModel.largestBidSize()) * graphWidth
                                
                                Rectangle()
                                    .foregroundColor(Color(hexString: ConstantColor.redGraphColor.hexCode))
                                    .frame(maxWidth: graphSize, alignment: .leading)
                                    .frame(height: 20)
                                
                                Text("\(item.size)")
                                    .frame(width: graphWidth)
                                
                            }
                            .frame(maxWidth: graphWidth)
                            .frame(height: 40)
                            .background(Color(hexString: ConstantColor.redBackgroundColor.hexCode))
                                       
                        }
                        .frame(height: 40)
                    }
                }
            }
            .frame(height : 1440) // 40 * 15 * 2 + 40 + 40
            
        }
        .navigationTitle(viewModel.marketData.koreanName)
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CoinAskingPriceView()
}