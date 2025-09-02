import SwiftUI

enum Appearance: String, Codable, CaseIterable {
    case light
    case dark
    case system
    
    var colorScheme: ColorScheme? {
        switch self {
            case .light: return .light
            case .dark: return .dark
            case .system: return nil
        }
    }
    
    var name: String {
        switch self {
            case .light: return Locale.current.language.languageCode?.identifier == "en" ? "Light" : "Hell"
            case .dark: return Locale.current.language.languageCode?.identifier == "en" ? "Dark" : "Dunkel"
            case .system: return Locale.current.language.languageCode?.identifier == "en" ? "System" : "System"
        }
    }
}

enum Language: String, Codable, CaseIterable {
    case en
    case de
    
    var name: String {
        switch self {
            case .en: return "English"
            case .de: return "Deutsch"
        }
    }
}


struct Settings: Codable, Equatable {
    var appearance: Appearance = .system
    var language: Language = .en
}
