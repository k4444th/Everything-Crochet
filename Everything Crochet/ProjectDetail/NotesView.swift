import SwiftUI

struct NotesView: View {
    
    @Binding var text: String
    @Binding var editMode: Bool
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Notes:").font(.title2).padding(.vertical, 8)
            
            TextField("Let your ideas unravel here...", text: $text,  axis: .vertical)
                .lineLimit(5...10) .disabled(!editMode)
        } .padding(.bottom)
    }
}

#Preview {
    NotesView(text: .constant(""), editMode: .constant(true))
}
