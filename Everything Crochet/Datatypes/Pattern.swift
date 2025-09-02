import SwiftUI

struct Pattern : Identifiable, Codable, Equatable {
    var id: Int = -1
    var name: String = ""
    var previewImage: Data?
    var tags: [String] = []
    var techniques: String = ""
    var notes: String = ""
    var pattern: Data?
}
