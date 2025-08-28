import SwiftUI

enum MainContent: CaseIterable{
    case contents
    case projects
    case patterns
    case stash
    case wips
    case stitches
    case wishlist
    case statistics
    case achievements
}

struct MainView: View {
    @State var presentSideMenu = false
    @State var currentContent: MainContent = .contents
        
    var body: some View {
        ZStack {
            VStack {
                NavbarView(presentSideMenu: $presentSideMenu)
                
                switch currentContent {
                    case .contents:
                        ContentView(presentSideMenu: $presentSideMenu, currentContent: $currentContent).frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .projects:
                        ProjectsView().frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .patterns:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .stash:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .wips:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .stitches:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .wishlist:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .statistics:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .achievements:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            
            SideMenuView(
                isShowing: $presentSideMenu,
                content: AnyView(SideMenuContentView(presentSideMenu: $presentSideMenu, currentContent: $currentContent))
            )
        }
    }
}

#Preview {
    MainView()
}
