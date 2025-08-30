import SwiftUI

struct TagsView: View {
    var tagColors = [Color.appPrimary, Color.appSecondary, Color.appSecondary2]
    
    @State var newTag: String = ""
    @State var showAddForm: Bool = false
    @Binding var tags: [String]
    @Binding var editMode: Bool
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView (.horizontal) {
                    HStack (alignment: .top) {
                        if editMode {
                            Button {
                                showAddForm.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.appSecondary2)
                                    .padding(.bottom, 4)
                            }
                        }
                        
                        if tags.count > 0 {
                            ForEach(Array(tags.enumerated()), id: \.offset) { index, tag in
                                TagView(tagName: tag, color: Color.appSecondary, editMode: $editMode, info: false)
                            }.padding(.bottom)
                        }
                    }.padding(.horizontal)
                }
                
                if showAddForm {
                    HStack {
                        Text("Tag name:")
                        TextField("eg. Amigurumi", text: $newTag) .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button {
                            showAddForm.toggle()
                            newTag = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        Button {
                            showAddForm.toggle()
                            print("Add tag '" + newTag + "'")
                            if newTag.count > 0 {
                                tags.append(newTag)
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
        } .padding(.bottom)
    }
}


#Preview {
    TagsView(tags: .constant(["Tunesian Crochet", "Blanket"]), editMode: .constant(true))
}
