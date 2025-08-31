import SwiftUI

struct ProjectsView: View {
    @AppStorage("projects") private var projectData: Data?
    
    @Binding var currentContent: MainContent
    @Binding var addMode: Bool
    
    @State var newProject: Project = Project()
    
    var body: some View {
        if addMode {
            VStack () {
                HStack{
                    Text("Create project").font(.title2)
                    Spacer()
                }
                
                Spacer()
                
                Button {
                    newProject = Project(
                        id: -1,
                        name: "New project",
                        previewImage: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png",
                        tags: [],
                        parts: [],
                        techniques: "",
                        startdate: "",
                        enddate: "",
                        deadline: "",
                        yarn: "",
                        notes: "",
                        patternLink: "",
                        progress: [],
                        progressPhotos: []
                    )
                    
                    var projects: [Project] = []
                    if let savedData = UserDefaults.standard.data(forKey: "projects"),
                       let decoded = try? JSONDecoder().decode([Project].self, from: savedData) {
                        projects = decoded
                    }
                    
                    projects.append(newProject)
                    
                    if let encoded = try? JSONEncoder().encode(projects) {
                        UserDefaults.standard.set(encoded, forKey: "projects")
                    }
                    
                } label: {
                    Text("Create new project") .padding(12) .tint(Color.lighter) .background(
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
                       let decodedProjects = try? JSONDecoder().decode([Project].self, from: projectData) {
                        ForEach(decodedProjects, id: \.id) { project in
                            ProjectCardView(
                                currentContent: $currentContent,
                                project: .constant(project)
                            )
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ProjectsView(currentContent: .constant(.contents), addMode: .constant(false))
}
