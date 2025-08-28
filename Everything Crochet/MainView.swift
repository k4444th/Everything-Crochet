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
    case timeline
}

struct MainView: View {
    @State private var presentSideMenu = false
    @State private var currentContent: MainContent = .contents
        
    var body: some View {
        ZStack {
            NavbarView(presentSideMenu: $presentSideMenu)
            
            switch currentContent {
                case .contents:
                    ContentView(presentSideMenu: $presentSideMenu)
                case .projects:
                    ProjectsView()
                case .patterns:
                    ContentView(presentSideMenu: $presentSideMenu)
                case .stash:
                    ContentView(presentSideMenu: $presentSideMenu)
                case .wips:
                    ContentView(presentSideMenu: $presentSideMenu)
                case .stitches:
                    ContentView(presentSideMenu: $presentSideMenu)
                case .wishlist:
                    ContentView(presentSideMenu: $presentSideMenu)
                case .statistics:
                    ContentView(presentSideMenu: $presentSideMenu)
                case .achievements:
                    ContentView(presentSideMenu: $presentSideMenu)
                case .timeline:
                    ContentView(presentSideMenu: $presentSideMenu)
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
