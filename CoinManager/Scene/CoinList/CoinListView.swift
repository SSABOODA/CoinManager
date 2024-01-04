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
            VStack {
                HStack {
                    HStack {
                        Text("코인명")
                            .font(.system(size: 13))
                    }
                    .background(.blue)
                    Spacer()
                    HStack {
                        Text("현재가")
                            .font(.system(size: 13))
                        Text("전일대비")
                            .font(.system(size: 13))
                        Text("거래대금")
                            .font(.system(size: 13))
                    }
                    .background(.red)
                    
                }
                .frame(height: 5)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal, 30)
                    .background(Color.gray)
            }
            
            ForEach(viewModel.filterMarket, id: \.self) { item in
                NavigationLink(value: item) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.koreanName)")
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                                .font(.system(size: 15))
                            Text(item.market)
                                .foregroundStyle(.gray)
                                .font(.system(size: 13))
                                
                        }
                        Spacer()
                        VStack {
                            Text("58,000,000")
                                .foregroundStyle(.black)
                                .font(.callout)
                            Text("")
                        }
                        
                        VStack {
                            Text("-0.48%")
                                .foregroundStyle(.black)
                                .font(.callout)
                            Text("30.00")
                                .foregroundStyle(.black)
                                .font(.caption)
                        }
                        
                        VStack {
                            Text("986,050백만")
                                .foregroundStyle(.black)
                                .font(.callout)
                            Text("")
                        }
                        
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                }
                Divider()
                    .frame(height: 0.5)
                    .padding(.horizontal, 30)
                    .background(Color.gray)
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
