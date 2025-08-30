import SwiftUI

struct TagsView: View {
    var tagColors = [Color.appPrimary, Color.appSecondary, Color.appSecondary2]
    
    @Binding var tags: [String]
    @Binding var editMode: Bool
    
    var body: some View {
        ScrollView (.horizontal) {
            HStack {
                if editMode {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.appSecondary2)
                }
                
                if tags.count > 0 {
                
                    // ForEach(Array(tags.enumerated()), id: \.offset) { index, tag in
                    //         TagView(tagName: tag, color: tagColors[index % tagColors.count])
                    // }
                    ForEach(Array(tags.enumerated()), id: \.offset) { index, tag in
                        TagView(tagName: tag, color: Color.appSecondary)
                    }
                }
            }.padding(.horizontal) .padding(.vertical)
        }.padding(.bottom)
    }
}

#Preview {
    TagsView(tags: .constant(["Tunesian Crochet", "Blanket"]), editMode: .constant(true))
}
