import SwiftUI

struct TagsView: View {
    var tagColors = [Color.appPrimary, Color.appSecondary, Color.appSecondary2]
    
    @State var editMode: Bool = false
    @State var newTag: String = ""
    @Binding var tags: [String]
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView (.horizontal) {
                    HStack (alignment: .top) {
                        if tags.count > 0 {
                            ForEach(Array(tags.enumerated()), id: \.offset) { index, tag in
                                TagView(tagName: tag, color: Color.lighter, editMode: $editMode, info: false, onDelete: { })
                            }
                        }
                    }.padding(.horizontal)
                }
            }
        }
    }
}


#Preview {
    TagsView(tags: .constant(["Tunesian Crochet", "Blanket"]))
}
