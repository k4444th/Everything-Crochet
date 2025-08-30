import SwiftUI

struct TagView: View {
    
    @State var tagName: String
    @State var color: Color
    @Binding var editMode: Bool
    @State var info: Bool
    
    var body: some View {
        ZStack {
            HStack (spacing: 0) {
                if editMode && !info {
                    Button  {
                        print("Delete tag '" + tagName + "'")
                    } label: {
                        Image(systemName: "multiply")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                            .tint(Color.lighter)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.appPrimary)
                            )
                    }
                }
                Text(tagName) .foregroundColor(Color.lighter)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            } .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)
            )
        }
    }
}

#Preview {
    TagView(tagName: "Test", color: Color.appSecondary, editMode: .constant(true), info: false)
}
