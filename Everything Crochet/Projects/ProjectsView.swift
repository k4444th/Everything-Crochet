import SwiftUI

struct ProjectsView: View {
    @AppStorage("projects") private var projectData: Data?
    
    @Binding var currentContent: MainContent
    @Binding var addMode: Bool
    @Binding var currentProject: Project
    
    @State var newProject: Project = Project()
    
    func createProject() {
        newProject = Project(
            id: 0,
            name: "Project name",
            previewImage: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"),
            tags: [],
            parts: ["Blanket"],
            techniques: "",
            startdate: "",
            enddate: "",
            deadline: "",
            yarn: "",
            notes: "",
            patternLink: "",
            progress: [[5, 20]],
            progressPhotos: []
        )
        
        var projects: [Project] = []
        if let savedData = UserDefaults.standard.data(forKey: "projects"),
           let decoded = try? JSONDecoder().decode([Project].self, from: savedData) {
            projects = decoded
        }
        
        newProject.id = (projects.map { $0.id }.max() ?? -1) + 1
        
        projects.append(newProject)
        
        if let encoded = try? JSONEncoder().encode(projects) {
            UserDefaults.standard.set(encoded, forKey: "projects")
        }
    }
    
    var body: some View {
        if addMode {
            VStack () {
                HStack{
                    Text("Create project").font(.title2)
                    Spacer()
                }
                
                Spacer()
                
                Button {
                    addMode = false

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
                            createProject()
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
    ProjectsView(currentContent: .constant(.contents), addMode: .constant(false), currentProject: .constant(Project(id: 0, name: "Checkered Tunesian Blanket", previewImage: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhnqZpQ6W8HhJCtjrathdXW4djHWyp9itXIg&s")!, tags: ["Blanket"], parts: ["Blanket"], techniques: "Tunesian Crochet", startdate: "27.08.2025", enddate: "-", deadline: "01.01.2026", yarn: "Lisa Premium (Gründl)", notes: "", patternLink: "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf", progress: [[5, 20]], progressPhotos: [URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhnqZpQ6W8HhJCtjrathdXW4djHWyp9itXIg&s"), URL(string: "https://i.ytimg.com/vi/YM75duvKGFY/maxresdefault.jpg")].compactMap { $0 })))
}
