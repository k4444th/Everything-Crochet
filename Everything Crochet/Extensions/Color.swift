import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let primary = Color("PrimaryColor")
    let secondary = Color("SecondaryColor")
    let tertiary = Color("TertiaryColor")
    let complementary = Color("ComplementaryColor")
}
