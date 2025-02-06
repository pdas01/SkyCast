import SwiftUI

extension Color {
    init(hex: UInt64) {
        let red = hex >> 16 & 0xff
        let green = hex >> 8 & 0xff
        let blue = hex & 0xff
        self.init(red: Double(red) / 255.0 , green: Double(green) / 255.0 , blue: Double(blue) / 255.0 )
    }
}

extension Color {
    struct skycast {
        static let gray = Color(hex: 0xC4C4C4)
        static let darkgray = Color(hex: 0x9A9A9A)
        static let sunnyYellow = Color(hex: 0xFFAC33)
        static let skyblue = Color(hex: 0x9CD5F2)
        static let background = Color(hex: 0xF2F2F2)
        static let black1 = Color(hex: 0x2C2C2C)
    }
}
