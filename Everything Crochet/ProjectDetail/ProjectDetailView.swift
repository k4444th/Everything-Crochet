import SwiftUI

struct ProjectDetailView: View {
    @State var progress = [24, 1008]
    
    var tagColors = [Color.appPrimary, Color.appSecondary, Color.appSecondary2]
    
    var projectName = "Checkered Tunesian Blanket"
    var tags = ["Tunesian Crochet", "Blanket", "Gründl Wolle"]
    var techniques = ["Tunesian Crochet"]
    var deadline = "01.01.2026"
    var yarn = ["Lisa Premium (Gründl)"]
    var difficulty = "medium"
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 6) {
                Text(projectName).font(.title).padding()
                
                ScrollView (.horizontal) {
                    HStack {
                        ForEach(Array(tags.enumerated()), id: \.offset) { index, tag in
                                TagView(tagName: tag, color: tagColors[index % tagColors.count])
                            }
                    }.padding(.horizontal)
                }.padding(.bottom)
                
                ProgressView(progress: $progress).padding(.horizontal)
                
                DetailsView(deadline: deadline, yarn: yarn, difficulty: difficulty).padding(.horizontal)
                
            }
        }
    }
}

#Preview {
    ProjectDetailView()
}
