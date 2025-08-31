import PhotosUI
import SwiftUI

struct ProjectDetailView: View {
    @Binding var editMode: Bool
    
    @State var selectedItem: PhotosPickerItem?
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
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {  return }
            guard let inputImage = UIImage(data: imageData) else { return }
            print("Import image to preview:")
            print(inputImage)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                AsyncImage(url: previewPhoto) { phase in
                    if let image = phase.image {
                        ZStack {
                            image
                                .resizable() .scaledToFill() .frame(maxWidth: .infinity) .frame(height: 150) .clipped()
                            if editMode {
                                Rectangle() .fill(Color.lighter) .opacity(0.3) .frame(maxWidth: .infinity) .frame(height: 150)
                                
                                PhotosPicker(selection: $selectedItem) {
                                    Image(systemName: "pencil.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(Color.accent)
                                        .padding()
                                }
                            }
                        }
                    }
                }
                
                Text(projectName).font(.title).padding(.horizontal) .padding(.top)
                
                if editMode {
                    VStack {
                        TagsEditModeView(editMode: $editMode, tags: $tags)
                        
                        DetailsEditModeView(techniques: $techniques, startdate: $startdate, enddate: $enddate, deadline: $deadline, yarn: $yarn)
                        
                        PartsEditModeView(progress: $progress, parts: $parts)
                        
                        PatternEditModeView(pdfUrl: patternLink).frame(height: 250)
                        
                        GalleryEditModeView(images: $progressPhotos)
                        
                    } .padding(.horizontal)
                }
                
                else {
                    TagsView(tags: $tags)
                    
                    DetailsView(techniques: $techniques, startdate: $startdate, enddate: $enddate, deadline: $deadline, yarn: $yarn).padding(.horizontal)
                    
                    RowCounterView(progress: $progress, parts: $parts).padding(.horizontal)

                    PatternView(pdfUrl: patternLink).padding(.horizontal).frame(height: 550)
                    
                    GalleryView(images: $progressPhotos)
                    
                    NotesView(text: $notes).padding(.horizontal)
                }
            }
        } .onChange(of: selectedItem, loadImage)
    }
}

#Preview {
    ProjectDetailView(editMode: .constant(true))
}
