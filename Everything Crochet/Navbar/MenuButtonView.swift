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
                Text("\(content)".uppercased())
                    .tint(Color.background)
            }.padding(.bottom, 8)
            
            Spacer()
        }
    }
}
