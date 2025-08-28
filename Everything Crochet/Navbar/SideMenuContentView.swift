
import SwiftUI

struct SideMenuContentView: View {
    
    @Binding var presentSideMenu: Bool
    @Binding var currentContent: MainContent
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button  {
                        presentSideMenu.toggle()
                    } label: {
                        Image(systemName: "multiply")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                            .tint(Color.background)
                    }
                    Spacer()
                }.frame(alignment: .top).padding(.bottom, 24)
                
                ForEach(MainContent.allCases, id: \.self) { contentName in
                    MenuButtonView(
                        content: contentName,
                        presentSideMenu: $presentSideMenu,
                        currentContent: $currentContent
                    )
                }
                
                Spacer()
            }
            .padding()
        }
    }
}
