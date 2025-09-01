import SwiftUI

struct TagView: View {
    
    @State var tagName: String
    @State var color: Color
    @Binding var editMode: Bool
    @State var info: Bool
    
    var onDelete: (() -> Void)?
    
    var body: some View {
        ZStack {
            HStack (spacing: 0) {
                if editMode && !info {
                    Button  {
                        onDelete?() 
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.appSecondary)
                    }
                }
                if color == Color.lighter {
                    Text(tagName) .foregroundColor(Color.accent)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }
                else {
                    Text(tagName) .foregroundColor(Color.lighter)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }
            } .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)
            )
        }
    }
}

#Preview {
    TagView(tagName: "Test", color: Color.lighter, editMode: .constant(true), info: false)
}
