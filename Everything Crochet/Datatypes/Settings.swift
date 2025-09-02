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
}

struct Settings: Codable, Equatable {
    var appearance: Appearance = .system
    var language: String = ""
}
