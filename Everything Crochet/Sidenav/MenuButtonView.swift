import SwiftUI

struct MenuButtonView: View {
    
    @State var content: MainContent
    @Binding var presentSideMenu: Bool
    @Binding var currentContent: MainContent
    
    var body: some View {
        HStack {
            Button() {
                currentContent = content
                presentSideMenu = false
            } label: {
                Text("_\(content)".dropFirst(1).uppercased())
                    .tint(Color.background)
            }.padding(.bottom, 8)
            
            Spacer()
        }
    }
}

#Preview {
    MenuButtonView(content: .contents, presentSideMenu: .constant(true), currentContent: .constant(.contents))
}
