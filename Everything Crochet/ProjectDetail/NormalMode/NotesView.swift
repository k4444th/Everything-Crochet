import SwiftUI

struct NotesView: View {
    
    @State var newText: String = ""
    @Binding var text: String
    
    @FocusState var notesFocused: Bool

    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Notes:").font(.title2).padding(.vertical, 8)
                
                Spacer()
                
                if notesFocused {
                    if text == newText {
                        Button{
                            notesFocused = false
                            text = newText
                        } label: {
                            Text("Save") .padding(12) .tint(Color.accent) .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.lighter)
                            )
                        }
                    }
                    else {
                        Button{
                            notesFocused = false
                            text = newText
                        } label: {
                            Text("Save") .padding(12) .tint(Color.lighter) .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.appSecondary)
                            )
                        }
                    }
                }
            }
            
            TextField("Let your ideas unravel here...", text: $newText,  axis: .vertical)
                .lineLimit(5...50) .focused($notesFocused)
            
        } .padding(.bottom) .onAppear(perform: { newText = text })
    }
}

#Preview {
    NotesView(text: .constant(""))
}
