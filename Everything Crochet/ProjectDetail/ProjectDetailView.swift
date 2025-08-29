import SwiftUI

struct ProjectDetailView: View {
    var tagColors = [Color.appPrimary, Color.appSecondary, Color.appSecondary2]
    
    var projectName = "Checkered Tunesian Blanket"
    var tags = ["Tunesian Crochet", "Blanket", "Gründl Wolle"]
    var techniques = ["Tunesian Crochet"]
    var deadline = "01.01.2026"
    var yarn = ["Lisa Premium (Gründl)"]
    var difficulty = "medium"
    
    var body: some View {
        ScrollView {
            VStack {
                Text(projectName).font(.title).padding(.horizontal)
                
                ScrollView (.horizontal) {
                    HStack {
                        ForEach(Array(tags.enumerated()), id: \.offset) { index, tag in
                                TagView(tagName: tag, color: tagColors[index % tagColors.count])
                            }
                    }.padding(.horizontal)
                }
                
                DetailsView(deadline: deadline, yarn: yarn, difficulty: difficulty).padding(.horizontal)
                
            }
        }
    }
}

#Preview {
    ProjectDetailView()
}
