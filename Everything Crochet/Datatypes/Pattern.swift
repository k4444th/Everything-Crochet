import SwiftUI

struct Pattern : Identifiable, Codable, Equatable {
    var id: Int = -1
    var name: String = ""
    var notes: String = ""
    var pattern: Data?
}
