import SwiftUI

struct ProjectDetailView: View {
    @Binding var editMode: Bool
    
    @State var previewPhoto: URL? = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhnqZpQ6W8HhJCtjrathdXW4djHWyp9itXIg&s")
    @State var projectName: String = "Checkered Tunesian Blanket"
    @State var tags: [String] = ["Blanket", "Something", "Test", "Testing"]
    @State var parts: [String] = ["Head", "Body"]
    @State var techniques: String = "Tunesian Crochet"
    @State var notes: String = ""
    @State var startdate: String = "27.08.2025"
    @State var enddate: String = "-"
    @State var deadline: String = "01.01.2026"
    @State var yarn: String = "Gründl: Lisa Premium"
    @State var patternLink: String = "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf"
    @State var progress: [[Int]] = [[24, 80], [36, 60]]
    @State var progressPhotos: [URL] = [
        URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhnqZpQ6W8HhJCtjrathdXW4djHWyp9itXIg&s"),
        URL(string: "https://i.ytimg.com/vi/YM75duvKGFY/maxresdefault.jpg")
    ].compactMap { $0 }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                AsyncImage(url: previewPhoto) { phase in
                    if let image = phase.image {
                        image
                            .resizable() .scaledToFill() .frame(maxWidth: .infinity) .frame(height: 150) .clipped()
                    }
                }
                
                Text(projectName).font(.title).padding(.horizontal) .padding(.top)
                
                if editMode {
                    VStack {
                        TagsEditModeView(editMode: $editMode, tags: $tags)
                        
                        DetailsEditModeView(techniques: $techniques, startdate: $startdate, enddate: $enddate, deadline: $deadline, yarn: $yarn)
                        
                        PartsEditModeView(progress: $progress, parts: $parts)
                        
                        // PatternEditMode
                        
                        GalleryEditModeView(images: $progressPhotos)
                        
                    } .padding(.horizontal)
                }
                
                else {
                    TagsView(tags: $tags)
                    
                    DetailsView(techniques: $techniques, startdate: $startdate, enddate: $enddate, deadline: $deadline, yarn: $yarn).padding(.horizontal)
                    
                    RowCounterView(progress: $progress, parts: $parts).padding(.horizontal)

                    PatternView(pdfUrl: patternLink).padding(.horizontal).frame(height: 550)
                    
                    GalleryView(images: $progressPhotos)
                    
                    NotesView(text: $notes, editMode: $editMode).padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    ProjectDetailView(editMode: .constant(true))
}
