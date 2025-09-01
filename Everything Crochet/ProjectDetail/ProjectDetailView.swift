import PhotosUI
import SwiftUI

struct ProjectDetailView: View {
    @Binding var editMode: Bool
    @Binding var project: Project
    
    @State var selectedItem: PhotosPickerItem?
//    @State var previewPhoto: URL? = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhnqZpQ6W8HhJCtjrathdXW4djHWyp9itXIg&s")
//    @State var projectName: String = "Karierte Tunesische Decke"
//    @State var tags: [String] = ["Decke", "Tunesisch Häkeln"]
//    @State var parts: [String] = ["Decke"]
//    @State var techniques: String = "Tunesisch Häkeln"
//    @State var notes: String = ""
//    @State var startdate: String = "27.08.2025"
//    @State var enddate: String = "-"
//    @State var deadline: String = "01.01.2026"
//    @State var yarn: String = "Gründl: Lisa Premium"
//    @State var patternLink: String = "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf"
//    @State var progress: [[Int]] = [[24, 80], [36, 60]]
//    @State var progressPhotos: [URL] = [
//        URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhnqZpQ6W8HhJCtjrathdXW4djHWyp9itXIg&s"),
//        URL(string: "https://i.ytimg.com/vi/YM75duvKGFY/maxresdefault.jpg")
//    ].compactMap { $0 }
    
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
                if let data = project.previewImage,
                   let uiImage = UIImage(data: data) {
                    ZStack {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                            .clipped()
                        
                        if editMode {
                            Rectangle()
                                .fill(Color.lighter)
                                .opacity(0.3)
                                .frame(maxWidth: .infinity)
                                .frame(height: 150)
                            
                            PhotosPicker(selection: $selectedItem) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.accent)
                                    .padding()
                            }
                        }
                    }
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                            .overlay(Text("No Image"))
                        
                        if editMode {
                            PhotosPicker(selection: $selectedItem) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.accent)
                                    .padding()
                            }
                        }
                    }
                }

                
                Text(project.name).font(.title).padding(.horizontal) .padding(.top)
                
                if editMode {
                    VStack {
                        TagsEditModeView(editMode: $editMode, tags: $project.tags)
                        
                        DetailsEditModeView(techniques: $project.techniques, startdate: $project.startdate, enddate: $project.enddate, deadline: $project.deadline, yarn: $project.yarn)
                        
                        PartsEditModeView(progress: $project.progress, parts: $project.parts)
                        
                        PatternEditModeView(pdfUrl: project.patternLink).frame(height: 250)
                        
                        GalleryEditModeView(images: $project.progressPhotos)
                        
                        DeleteEditModeView()
                        
                    } .padding(.horizontal)
                }
                
                else {
                    VStack {
                        TagsView(tags: $project.tags)
                        
                        DetailsView(techniques: $project.techniques, startdate: $project.startdate, enddate: $project.enddate, deadline: $project.deadline, yarn: $project.yarn).padding(.horizontal)
                        
                        RowCounterView(progress: $project.progress, parts: $project.parts).padding(.horizontal)

                        PatternView(pdfUrl: project.patternLink).padding(.horizontal)
                        
                        GalleryView(images: $project.progressPhotos)
                        
                        NotesView(text: $project.notes).padding(.horizontal)
                    }
                }
            }
        } .onChange(of: selectedItem, loadImage)
    }
}

#Preview {
    ProjectDetailView(editMode: .constant(true), project: .constant(Project(id: 0, name: "Checkered Tunesian Blanket", previewImage: Data(), tags: ["Blanket"], parts: ["Blanket"], techniques: "Tunesian Crochet", startdate: "27.08.2025", enddate: "-", deadline: "01.01.2026", yarn: "Lisa Premium (Gründl)", notes: "", patternLink: "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf", progress: [[5, 20]], progressPhotos: [URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhnqZpQ6W8HhJCtjrathdXW4djHWyp9itXIg&s"), URL(string: "https://i.ytimg.com/vi/YM75duvKGFY/maxresdefault.jpg")].compactMap { $0 })))
}
