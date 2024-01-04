//
//  TopTapView.swift
//  CoinManager
//
//  Created by 한성봉 on 1/3/24.
//

import SwiftUI

enum TapInfo : String, CaseIterable {
    case ask = "호가"
    case chart = "차트"
    case price = "시세"
    case info = "정보"
}

struct TopTapView: View {
    @State private var selectedPicker: TapInfo = .info
    
    var body: some View {
        Picker("Pick", selection: $selectedPicker) {
            ForEach(TapInfo.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

#Preview {
    TopTapView()
}


struct TapView: View {
    var tapView: TapInfo
    
    @StateObject var viewModel = CoinAskingPriceViewModel(
        market: Market(
            market: "KRW-BTC",
            koreanName: "비트코인",
            englishName: "Bitcoin"
        )
    )
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
//            switch tapView {
//            case .ask:
//                CoinAskingPriceView()
//            case .chart:
//                <#code#>
//            case .price:
//                <#code#>
//            case .info:
//                <#code#>
//            }
        }
    }
}
