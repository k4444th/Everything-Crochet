import SwiftUI

struct Project : Identifiable, Codable, Equatable {
    var id: Int = -1
    var name: String = ""
    var previewImage: Data?
    var tags: [String] = []
    var parts: [String] = []
    var techniques: String = ""
    var startdate: String = ""
    var enddate: String = ""
    var deadline: String = ""
    var yarn: String = ""
    var notes: String = ""
    var patternLink: String = ""
    var progress: [[Int]] = []
    var progressPhotos: [Data] = []
}
