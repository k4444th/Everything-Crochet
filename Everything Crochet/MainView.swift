import SwiftUI

enum MainContent: CaseIterable{
    case contents
    case projects
    case project_detail
    case patterns
    case stash
    case wips
    case stitches
    case wishlist
    case statistics
    case achievements
    
    var title: String {
        switch self {
            case .contents: return "Contents"
            case .projects: return "Projects"
            case .project_detail: return ""
            case .patterns: return "Patterns"
            case .stash: return "Stash"
            case .wips: return "WIPs"
            case .stitches: return "Stitches"
            case .wishlist: return "Wishlist"
            case .statistics: return "Statistics"
            case .achievements: return "Achievements"
        }
    }
}

struct MainView: View {
    @State var presentSideMenu = false
    @State var currentContent: MainContent = .contents
        
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                NavbarView(presentSideMenu: $presentSideMenu, currentContent: $currentContent)
                
                switch currentContent {
                    case .contents:
                        ContentView(presentSideMenu: $presentSideMenu, currentContent: $currentContent).frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .projects:
                        ProjectsView(currentContent: $currentContent).frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .project_detail:
                        ProjectDetailView().frame(maxWidth: .infinity, maxHeight: .infinity)
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
