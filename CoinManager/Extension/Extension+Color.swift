//
//  Extension+Color.swift
//  CoinManager
//
//  Created by 한성봉 on 1/3/24.
//

import SwiftUI

extension Color {
    // random Color
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
    
    // hexcode init
    init(hexString: String, opacity: Double = 1.0) {
        
        let hex: Int = Int(hexString, radix: 16)!
        
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
}
