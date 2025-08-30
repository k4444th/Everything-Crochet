import SwiftUI

struct TagsView: View {
    var tagColors = [Color.appPrimary, Color.appSecondary, Color.appSecondary2]
    
    @State var newTag: String = ""
    @Binding var tags: [String]
    @Binding var editMode: Bool
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView (.horizontal) {
                    HStack (alignment: .top) {
                        if tags.count > 0 {
                            ForEach(Array(tags.enumerated()), id: \.offset) { index, tag in
                                TagView(tagName: tag, color: Color.lighter, editMode: $editMode, info: false)
                            }.padding(.bottom)
                        }
                    }.padding(.horizontal)
                }
                
                if editMode {
                    HStack {
                        Text("New tag:")
                        TextField("eg. Amigurumi", text: $newTag) .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button {
                            newTag = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        Button {
                            if newTag.count > 0 {
                                tags.append(newTag)
                                print("Add tag '" + newTag + "'")
                            }
                            
                            newTag = ""
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    } .padding(.horizontal)
                }
            }
        }
    }
}


#Preview {
    TagsView(tags: .constant(["Tunesian Crochet", "Blanket"]), editMode: .constant(true))
}
