import SwiftUI

enum AppIcon: CaseIterable {
    case `default`
    case dark

    var name: String? {
        switch self {
        case .default:
            return nil
        case .dark:
            return "AppIconDark"
        }
    }

    var description: String {
        switch self {
        case .default:
            return Locale.current.language.languageCode?.identifier == "en" ? "Default" : "Standard"
        case .dark:
            return Locale.current.language.languageCode?.identifier == "en" ? "Dark" : "Dunkel"
        }
    }

    var icon: Image {
        switch self {
        case .default:
            return Image("AppIcon")
        case .dark:
            return Image("AppIconDark")
        }
    }
}


extension AppIcon {
    init(from name: String) {
        switch name {
        case "AppIconDark": self = .dark
        default: self = .default
        }
    }
}
