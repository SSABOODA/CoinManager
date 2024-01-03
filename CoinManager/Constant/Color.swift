//
//  Color.swift
//  CoinManager
//
//  Created by 한성봉 on 1/3/24.
//

import Foundation

enum ConstantColor {
    case blueTextColor
    case redTextColor
    
    case blueGraphColor
    case redGraphColor
    
    case blueBackgroundColor
    case redBackgroundColor
    
    var hexCode: String {
        switch self {
        case .blueTextColor:
            return "1F77BB"
        case .redTextColor:
            return "E74F33"
        case .blueGraphColor:
            return "CDE0F6"
        case .redGraphColor:
            return "F8D8D6"
        case .blueBackgroundColor:
            return "EEF6FF"
        case .redBackgroundColor:
            return "FFF0EF"
        }
    }
}
