import PhotosUI
import SwiftUI

struct ProjectDetailView: View {
    @Binding var editMode: Bool
    @Binding var project: Project
    @Binding var currentContent: MainContent
    
    @State var selectedItem: PhotosPickerItem?
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {  return }
            
            project.previewImage = imageData
        }
    }
    
    func updateProjectInUserDefaults() {
        var projects: [Project] = []
        if let data = UserDefaults.standard.data(forKey: "projects"),
           let decoded = try? JSONDecoder().decode([Project].self, from: data) {
            projects = decoded
        }
        
        if project.name.count > 0 {
            if let index = projects.firstIndex(where: { $0.id == project.id }) {
                projects[index] = project
            }
        }
        else {
            if let index = projects.firstIndex(where: { $0.id == project.id }) {
                projects.remove(at: index)
            }
            currentContent = .projects
        }

        if let encoded = try? JSONEncoder().encode(projects) {
            UserDefaults.standard.set(encoded, forKey: "projects")
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
                            Rectangle()
                                .fill(Color.accent)
                                .opacity(0.3)
                                .frame(maxWidth: .infinity)
                                .frame(height: 150)
                            
                            PhotosPicker(selection: $selectedItem) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.lighter)
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
                        
                        PatternEditModeView(patternData: $project.pattern).frame(height: 250)
                        
                        GalleryEditModeView(images: $project.progressPhotos)
                        
                        DeleteEditModeView(project: $project)
                        
                    } .padding(.horizontal)
                }
                
                else {
                    VStack {
                        TagsView(tags: $project.tags)
                        
                        DetailsView(techniques: $project.techniques, startdate: $project.startdate, enddate: $project.enddate, deadline: $project.deadline, yarn: $project.yarn).padding(.horizontal)
                        
                        RowCounterView(progress: $project.progress, parts: $project.parts).padding(.horizontal)

                        PatternView(patternData: $project.pattern).padding(.horizontal)
                        
                        GalleryView(images: $project.progressPhotos)
                        
                        NotesView(text: $project.notes).padding(.horizontal)
                    }
                }
            }
        } .onChange(of: selectedItem, loadImage) .onChange(of: project) { updateProjectInUserDefaults() }
    }
}

#Preview {
    ProjectDetailView(editMode: .constant(false), project: .constant(Project(id: 0, name: "Checkered Tunesian Blanket", previewImage: Data(), tags: ["Blanket"], parts: ["Blanket"], techniques: "Tunesian Crochet", startdate: "27.08.2025", enddate: "-", deadline: "01.01.2026", yarn: "Lisa Premium (Gründl)", notes: "", pattern: Data(), progress: [[5, 20]], progressPhotos: [].compactMap { $0 })), currentContent: .constant(.project_detail))
}
