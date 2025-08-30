
import SwiftUI

struct SideMenuContentView: View {
    
    @Binding var presentSideMenu: Bool
    @Binding var currentContent: MainContent
    
    var body: some View {
        ZStack {
            Color.appSecondary
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button  {
                        presentSideMenu.toggle()
                    } label: {
                        Image(systemName: "multiply")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                            .tint(Color.lighter)
                    }
                    Spacer()
                }.frame(alignment: .top).padding(.bottom, 24)
                
                VStack {
                    ForEach(MainContent.allCases, id: \.self) { contentName in
                        if contentName.title != "" {
                            MenuButtonView(
                                content: contentName.title,
                                link: contentName,
                                presentSideMenu: $presentSideMenu,
                                currentContent: $currentContent
                            )
                        }
                    }
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    SideMenuContentView(presentSideMenu: .constant(false), currentContent: .constant(.contents))
}
