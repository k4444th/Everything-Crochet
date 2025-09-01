import SwiftUI

struct ProjectCardView: View {
    
    @Binding var currentContent: MainContent
    @Binding var project: Project
    @Binding var currentProject: Project
    
    var body: some View {
        Button{
            currentContent = .project_detail
            currentProject = project
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.lighter) .foregroundColor(.clear)
                
                VStack (spacing: 0) {
                    if let data = project.previewImage,
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 150)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 350, height: 150)
                            .overlay(
                                Text("No Image")
                                    .foregroundColor(.secondary)
                            )
                    }

                    
                    Text(project.name).padding()
                }
            }.frame(width: 350, height: 200) .cornerRadius(20)
        }.padding()
    }
}

#Preview {
    ProjectCardView(currentContent: .constant(.contents), project: .constant(Project()), currentProject: .constant(Project()))
}
