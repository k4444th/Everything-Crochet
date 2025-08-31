import SwiftUI

struct TagsEditModeView: View {
    
    @State var newTag: String = ""
    
    @Binding var editMode: Bool
    @Binding var tags: [String]
                        
    @FocusState var newTagFocused: Bool
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Tags:").font(.title2).padding(.vertical, 8)
            
            FlowLayoutView(items: tags, spacing: 8) { tag in
                TagView(tagName: tag, color: Color.lighter, editMode: $editMode, info: false)
            }
            
            HStack {
                Text("New tag:")
                TextField("eg. Amigurumi", text: $newTag) .textFieldStyle(RoundedBorderTextFieldStyle()) .focused($newTagFocused)
                Button {
                    newTagFocused = false
                    newTag = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.appSecondary)
                }
                Button {
                    newTagFocused = false
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
            }
        }
    }
}

#Preview {
    TagsEditModeView(editMode: .constant(true), tags: .constant(["Hello World", "Crochet", "Blanket", "Something"]))
}

