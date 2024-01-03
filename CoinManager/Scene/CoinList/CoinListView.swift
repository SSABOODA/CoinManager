//
//  ConListView.swift
//  CoinManager
//
//  Created by 한성봉 on 1/2/24.
//

import SwiftUI

struct CoinListView: View {
    
    @ObservedObject var viewModel = CoinListViewModel()
    @State var searchQueryString = ""
    
    var body: some View {
        LazyVStack {
            ForEach(viewModel.filterMarket ?? [], id: \.self) { item in
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
                    .padding(20)
                }
            }
        } // LazyVStack
        .onAppear {
            viewModel.fetchAllMarket()
        }
        .navigationDestination(for: Market.self) { item in
            let viewModel = CoinAskingPriceViewModel(market: item)
            CoinAskingPriceView(viewModel: viewModel)
        }
        .searchable(
            text: $searchQueryString,
            placement: .navigationBarDrawer,
            prompt: "코인명, 심볼 검색"
        )
        .onChange(of: searchQueryString) { newValue in
            self.viewModel.filterMarket = self.searchResults
        }
    } // body
    
    var searchResults: [Market] {
        if searchQueryString.isEmpty {
            return viewModel.market
        } else {
            return viewModel.market.filter {
                $0.koreanName.contains(searchQueryString) || $0.englishName.contains(searchQueryString)
            }
        }
    }
}

#Preview {
    CoinListView()
}
