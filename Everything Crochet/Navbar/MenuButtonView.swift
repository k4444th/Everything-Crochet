import SwiftUI

struct MenuButtonView: View {
    
    @State var content: String
    @State var link: MainContent
    @Binding var presentSideMenu: Bool
    @Binding var currentContent: MainContent
    
    var body: some View {
        HStack {
            Button() {
                currentContent = link
                presentSideMenu = false
            } label: {
                Text("\(content)".uppercased())
                    .tint(Color.lighter).font(.title2)
            }.padding(.bottom, 8)
            
            Spacer()
        }
    }
}
