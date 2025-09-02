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
                    Button("Save") {
                        notesFocused = false
                        text = newText
                    }
                }
            }
            
            TextField("Let your ideas unravel here...", text: $newText,  axis: .vertical)
                .lineLimit(5...10) .focused($notesFocused)
            
        } .padding(.bottom) .onAppear(perform: { newText = text })
    }
}

#Preview {
    NotesView(text: .constant(""))
}
