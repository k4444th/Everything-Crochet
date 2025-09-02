import SwiftUI

struct Project_1 : Identifiable, Codable, Equatable {
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
    var pattern: Data?
    var progress: [[Int]] = []
    var progressPhotos: [Data] = []
}
