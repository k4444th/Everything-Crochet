import SwiftUI

struct Pattern : Identifiable, Codable, Equatable {
    var id: Int = -1
    var name: String = ""
    var type: PatternType = .pdf
    var previewImage: Data?
    var tags: [String] = []
    var notes: String = ""
    var pdfPattern: Data?
    var imagePattern: [Data] = []
    var writtenPattern: String = ""
}

enum PatternType: String, Codable, CaseIterable {
    case written
    case image
    case pdf
    
    var name: String {
        switch self {
            case .written: return Locale.current.language.languageCode?.identifier == "en" ? "Written" : "Geschrieben"
            case .image: return Locale.current.language.languageCode?.identifier == "en" ? "Image" : "Foto"
            case .pdf: return Locale.current.language.languageCode?.identifier == "en" ? "PDF" : "PDF"
        }
    }
}
