import SwiftUI

struct TagView: View {
    
    @State var tagName: String
    @State var color: Color
    
    var body: some View {
        Text(tagName) .foregroundColor(Color.background)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)
            )
    }
}
