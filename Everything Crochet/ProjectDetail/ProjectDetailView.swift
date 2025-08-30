import SwiftUI

struct ProjectDetailView: View {
    @Binding var editMode: Bool
    @State var projectName: String = "Checkered Tunesian Blanket"
    @State var tags: [String] = ["Blanket"]
    @State var techniques: [String] = ["Tunesian Crochet"]
    @State var notes: String = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    @State var startdate: String = "01.01.2025"
    @State var enddate: String = "-"
    @State var deadline: String = "01.01.2026"
    @State var yarn: [String] = ["Gründl: Lisa Premium"]
    @State var patternLink: String = "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf"
    
    @State var progress: [Int] = [24, 80]
    @State var progressPhotos: [URL] = [
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"),
         URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"),
         URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png")
    ].compactMap { $0 }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                Text(projectName).font(.title).padding(.horizontal)
                
                
                TagsView(tags: $tags, editMode: $editMode)
                
                ProgressView(progress: $progress, editMode: $editMode).padding(.horizontal)
                
                GalleryView(images: $progressPhotos)
                
                DetailsView(techniques: $techniques, startdate: $startdate, enddate: $enddate, deadline: $deadline, yarn: $yarn).padding(.horizontal)
                
                RowCounterView(row: $progress[0]).padding(.horizontal)
                
                PatternView(pdfUrl: patternLink).padding(.horizontal).frame(height: 550)
                
                NotesView(text: $notes).padding(.horizontal)
            }.padding(.top)
        }
    }
}

#Preview {
    ProjectDetailView(editMode: .constant(false))
}
