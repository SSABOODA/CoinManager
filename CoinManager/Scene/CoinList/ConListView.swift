//
//  ConListView.swift
//  CoinManager
//
//  Created by 한성봉 on 1/2/24.
//

import SwiftUI

struct ConListView: View {
    
    @ObservedObject var viewModel = CoinListViewModel()
    
    var body: some View {
        
        LazyVStack {
            ForEach(viewModel.market, id: \.self) { item in
                NavigationLink(value: item) {
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text(item.koreanName)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            
                            Text(item.englishName)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        Text(item.market)
                            .foregroundStyle(.black)
                    }
                    .padding(18)
                }
            }
        }
        .onAppear {
            viewModel.fetchAllMarket()
        }
        .navigationDestination(for: Market.self) { item  in

//            let viewModel = SocketTestViewModel(market: item)
//            SocketTestView(viewModel: viewModel)
        }
    }
}

#Preview {
    ConListView()
}
