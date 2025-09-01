import PhotosUI
import SwiftUI

struct ProjectsView: View {
    @AppStorage("projects") private var projectData: Data?
    
    @Binding var currentContent: MainContent
    @Binding var addMode: Bool
    @Binding var currentProject: Project
    
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    
    @State var showError: Bool = false
    
    @State var newProject: Project = Project(
        id: 0,
        name: "",
        previewImage: Data(),
        tags: [],
        parts: ["Project name"],
        techniques: "",
        startdate: "",
        enddate: "",
        deadline: "",
        yarn: "",
        notes: "",
        patternLink: "",
        progress: [[0, 10]],
        progressPhotos: []
    )
    
    func createProject() {
        if newProject.name.count > 0 {
            var projects: [Project] = []
            if let projectData,
               let decoded = try? JSONDecoder().decode([Project].self, from: projectData) {
                projects = decoded
            }

            newProject.id = (projects.map { $0.id }.max() ?? -1) + 1
            newProject.parts = [newProject.name]

            if let selectedItem {
                Task {
                    if let data = try? await selectedItem.loadTransferable(type: Data.self) {
                        newProject.previewImage = data

                        projects.append(newProject)
                        if let encoded = try? JSONEncoder().encode(projects) {
                            projectData = encoded
                        }

                        resetNewProject()
                    }
                }
                return
            }

            projects.append(newProject)
            if let encoded = try? JSONEncoder().encode(projects) {
                projectData = encoded
            }

            resetNewProject()
        }
        else {
            showError = true
        }
    }

    private func resetNewProject() {
        newProject = Project(
            id: 0,
            name: "",
            previewImage: nil,
            tags: [],
            parts: [""],
            techniques: "",
            startdate: "",
            enddate: "",
            deadline: "",
            yarn: "",
            notes: "",
            patternLink: "",
            progress: [[0, 10]],
            progressPhotos: []
        )
    }
    
    var body: some View {
        if addMode {
            VStack (alignment: .leading) {
                HStack{
                    Text("Create project").font(.title)
                    Spacer()
                } .padding(.bottom)
                
                HStack {
                    Text("Project name:")
                    TextField("eg. My first amigurumi", text: $newProject.name) .textFieldStyle(RoundedBorderTextFieldStyle())

                }
                
                if showError {
                    HStack {
                        Spacer()
                        if Locale.current.language.languageCode?.identifier == "en" {
                            TagView(tagName: "Project name cannot be emty!", color: Color.appSecondary, editMode: .constant(false), info: true, onDelete:{  })
                        }
                        else {
                            TagView(tagName: "Der Projektname darf nicht leer sein!", color: Color.appSecondary, editMode: .constant(false), info: true, onDelete: { })
                        }
                        
                        Spacer()
                    }
                }
                
                Text("Details:").font(.title2).padding(.vertical, 8)
                
                let columns = [
                    GridItem(.fixed(30), alignment: .top),
                    GridItem(.flexible(), alignment: .top)
                ]
                
                LazyVGrid(columns: columns, alignment: .leading) {
                    Image(systemName: "hammer")
                            .imageScale(.large)
                            .foregroundColor(Color.accent).padding(.bottom, 8) .padding(.top, 4)
                    
                    HStack {
                        Text("Techniques:")
                        TextField("eg. Crochet", text: $newProject.techniques) .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Image(systemName: "scissors")
                            .imageScale(.large)
                            .foregroundColor(Color.accent).padding(.bottom, 8) .padding(.top, 6)
                    
                    HStack {
                        Text("Yarn:")
                        TextField("eg. Cotton yarn", text: $newProject.yarn) .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Image(systemName: "clock")
                            .imageScale(.large)
                            .foregroundColor(Color.accent).padding(.bottom, 8) .padding(.top, 6)
                    
                    VStack {
                        HStack {
                            Text("Startdate:")
                            TextField("eg. Aug 28th 2025", text: $newProject.startdate) .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        HStack {
                            Text("Enddate:")
                            TextField("eg. Sep 3rd 2025", text: $newProject.enddate) .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    
                    Image(systemName: "calendar")
                        .imageScale(.large)
                        .foregroundColor(Color.accent).padding(.bottom, 8) .padding(.top, 6)
                    
                    HStack {
                        Text("Deadline:")
                        TextField("eg. Sep 1st 2025", text: $newProject.deadline) .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                } .padding(.bottom)
                
                HStack{
                    Text("Preview image:").font(.title2)
                    Spacer()
                } .padding(.bottom)
                
                VStack {
                    HStack {
                        PhotosPicker(selection: $selectedItem) {
                            Text("Pick a photo")
                        }  .onChange(of: selectedItem) { oldValue, newValue in
                            if let newValue {
                                Task {
                                    if let data = try? await newValue.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        selectedImage = uiImage
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    
                    if let uiImage = selectedImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: .infinity, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                } .padding(.bottom)
                
                HStack {
                    Spacer()
                    Button {
                        if newProject.name.count > 0 {
                            addMode = false
                        }
                    
                        createProject()
                    } label: {
                        Text("Create new project")
                            .padding(12)
                            .tint(Color.lighter)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.appPrimary)
                            )
                    }
                    Spacer()
                }
                Spacer()
            }.padding()
        }
        else {
            ScrollView {
                VStack {
                    if let projectData,
                       let decodedProjects = try? JSONDecoder().decode([Project].self, from: projectData),
                       !decodedProjects.isEmpty {
                        
                        ForEach(decodedProjects, id: \.id) { project in
                            ProjectCardView(
                                currentContent: $currentContent,
                                project: .constant(project),
                                currentProject: $currentProject
                            )
                        }
                        
                    } else {
                        Button {
                            addMode = true
                        } label: {
                            Text("Create your first project!")
                                .padding(12)
                                .tint(Color.lighter)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.appPrimary)
                                )
                        }.padding()
                    }
                } .padding()
            }
        }
    }
}

#Preview {
    ProjectsView(currentContent: .constant(.contents), addMode: .constant(true), currentProject: .constant(Project(id: 0, name: "Checkered Tunesian Blanket", previewImage: Data(), tags: ["Blanket"], parts: ["Blanket"], techniques: "Tunesian Crochet", startdate: "27.08.2025", enddate: "-", deadline: "01.01.2026", yarn: "Lisa Premium (Gründl)", notes: "", patternLink: "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf", progress: [[5, 20]], progressPhotos: [].compactMap { $0 })))
}
