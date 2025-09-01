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
    ProjectCardView(currentContent: .constant(.contents), project: .constant(Project(id: 0, name: "Checkered Tunesian Blanket", previewImage: Data(), tags: ["Blanket"], parts: ["Blanket"], techniques: "Tunesian Crochet", startdate: "27.08.2025", enddate: "-", deadline: "01.01.2026", yarn: "Lisa Premium (Gründl)", notes: "", patternLink: "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf", progress: [[5, 20]], progressPhotos: [URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhnqZpQ6W8HhJCtjrathdXW4djHWyp9itXIg&s"), URL(string: "https://i.ytimg.com/vi/YM75duvKGFY/maxresdefault.jpg")].compactMap { $0 })), currentProject: .constant(Project(id: 0, name: "Checkered Tunesian Blanket", previewImage: Data(), tags: ["Blanket"], parts: ["Blanket"], techniques: "Tunesian Crochet", startdate: "27.08.2025", enddate: "-", deadline: "01.01.2026", yarn: "Lisa Premium (Gründl)", notes: "", patternLink: "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf", progress: [[5, 20]], progressPhotos: [URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhnqZpQ6W8HhJCtjrathdXW4djHWyp9itXIg&s"), URL(string: "https://i.ytimg.com/vi/YM75duvKGFY/maxresdefault.jpg")].compactMap { $0 })))
}
