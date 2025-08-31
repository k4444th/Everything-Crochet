import SwiftUI

struct NotesView: View {
    
    @Binding var text: String
    
    @FocusState var notesFocused: Bool

    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Notes:").font(.title2).padding(.vertical, 8)
                
                Spacer()
                
                if notesFocused {
                    Button("Submit") {
                        notesFocused = false
                    }
                }
            }
            
            TextField("Let your ideas unravel here...", text: $text,  axis: .vertical)
                .lineLimit(5...10) .focused($notesFocused)
            
        } .padding(.bottom)
    }
}

#Preview {
    NotesView(text: .constant(""))
}
