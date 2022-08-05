//
//  ColorExt.swift
//  mobile_browser
//
//  Created by Charles on 8/4/22.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    struct Palette {
        let dark = Color(hex: 0x202124)
        let medDark = Color(hex: 0x282C2F)
        let light = Color(hex: 0x323639)
        let searchBar = Color(hex: 0xD8D7D3)
    }
    
    static let defaultPalette = Palette()
}
