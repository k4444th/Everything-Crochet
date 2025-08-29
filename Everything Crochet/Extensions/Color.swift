import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let appPrimary = Color("AppPrimaryColor")
    let appSecondary = Color("AppSecondaryColor")
    let appSecondary2 = Color("AppSecondary2Color")
    let appComplementary = Color("AppComplementaryColor")
}
