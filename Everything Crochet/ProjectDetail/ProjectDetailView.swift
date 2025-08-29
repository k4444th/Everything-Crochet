import SwiftUI

struct ProjectDetailView: View {
    @State var techniques = ["Tunesian Crochet"]
    @State var notes = ""
    @State var startdate = "01.01.2025"
    @State var enddate = "-"
    @State var deadline = "01.01.2026"
    @State var yarn = ["Gründl: Lisa Premium"]
    @State var patternLink = "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf"
    
    @State var progress = [24, 1008]
    @State var progressPhotos: [URL] = [
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"),
         URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"),
         URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png")
    ].compactMap { $0 }
    
    var tagColors = [Color.appPrimary, Color.appSecondary, Color.appSecondary2]
    
    var projectName = "Checkered Tunesian Blanket"
    var tags = ["Tunesian Crochet", "Blanket"]
    
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 6) {
                Text(projectName).font(.title).padding()
                
                ScrollView (.horizontal) {
                    HStack {
                        ForEach(Array(tags.enumerated()), id: \.offset) { index, tag in
                                TagView(tagName: tag, color: tagColors[index % tagColors.count])
                        }
                    }.padding(.horizontal)
                }
                
                ProgressView(progress: $progress).padding()
                
                ProgressPhotosView(images: $progressPhotos)
                
                DetailsView(techniques: $techniques, startdate: $startdate, enddate: $enddate, deadline: $deadline, yarn: $yarn).padding(.horizontal)
                
                RowCounterView(row: $progress[0]).padding(.horizontal)
                
                PatternView(pdfUrl: patternLink).padding(.horizontal).frame(height: 550)
                
                NotesView(text: $notes).padding(.horizontal)
            }
        }
    }
}

#Preview {
    ProjectDetailView()
}
