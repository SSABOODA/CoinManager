//
//  MainView.swift
//  CoinManager
//
//  Created by 한성봉 on 1/3/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CoinListView()
                } // VStack
            } // ScrollView
            .refreshable {
                self.viewModel.markets.shuffle()
            }
            .navigationBarTitle("거래소")
        }.accentColor(.black) // NavigationStack
    } // body
}

#Preview {
    MainView()
}
