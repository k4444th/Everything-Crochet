import SwiftUI

enum MainContent: CaseIterable{
    case contents
    case projects
    case project_detail
    case patterns
    case pattern_detail
    case stash
    case wips
    case stitches
    case wishlist
    case statistics
    case achievements
    case timeline
    case settings
    
    var title: String {
        switch self {
            case .contents: return Locale.current.language.languageCode?.identifier == "en" ? "Contents" : "Übersicht"
            case .projects: return Locale.current.language.languageCode?.identifier == "en" ? "Projects" : "Projekte"
            case .project_detail: return Locale.current.language.languageCode?.identifier == "en" ? "(Project Details)" : "(Projekt details)"
            case .patterns: return Locale.current.language.languageCode?.identifier == "en" ? "Patterns" : "Anleitungen"
            case .pattern_detail: return Locale.current.language.languageCode?.identifier == "en" ? "(Pattern Details)" : "(Anleitungsdetails)"
            case .stash: return Locale.current.language.languageCode?.identifier == "en" ? "Stash" : "Lager"
            case .wips: return Locale.current.language.languageCode?.identifier == "en" ? "WIPs" : "WIPs"
            case .stitches: return Locale.current.language.languageCode?.identifier == "en" ? "Stitches" : "Maschen"
            case .wishlist: return Locale.current.language.languageCode?.identifier == "en" ? "Wishlist" : "Wunschliste"
            case .statistics: return Locale.current.language.languageCode?.identifier == "en" ? "Statistics" : "Statistik"
            case .achievements: return Locale.current.language.languageCode?.identifier == "en" ? "Achievements" : "Erfolge"
            case .timeline: return Locale.current.language.languageCode?.identifier == "en" ? "Timeline" : "Zeitleiste"
            case .settings: return Locale.current.language.languageCode?.identifier == "en" ? "Settings" : "Einstellungen"
        }
    }
}

struct MainView: View {
    @State var settings: Settings = Settings()
    
    @State var presentSideMenu = false
    @State var currentContent: MainContent = .contents
    
    @State var currentProject: Project = Project()
    @State var currentPattern: Pattern = Pattern()
   
    @State var editModeVisible: Bool = false
    @State var editMode: Bool = false
    
    @State var addIconVisible: Bool = false
    @State var addMode: Bool = false
        
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                NavbarView(presentSideMenu: $presentSideMenu, currentContent: $currentContent, editMode: $editMode, editModeVisible: $editModeVisible, addIconVisible: $addIconVisible, addMode: $addMode)
                
                switch currentContent {
                    case .contents:
                        ContentView(presentSideMenu: $presentSideMenu, currentContent: $currentContent).frame(maxWidth: .infinity, maxHeight: .infinity).onAppear {
                                editMode = false
                                addMode = false
                                editModeVisible = false
                                addIconVisible = false
                            }
                    case .projects:
                    ProjectsView(currentContent: $currentContent, addMode: $addMode, currentProject: $currentProject).frame(maxWidth: .infinity, maxHeight: .infinity) .onAppear {
                                editMode = false
                                addMode = false
                                editModeVisible = false
                                addIconVisible = true
                            }
                    case .project_detail:
                    ProjectDetailView(editMode: $editMode, project: $currentProject, currentContent: $currentContent).frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear {
                            editMode = false
                            addMode = false
                                editModeVisible = true
                                addIconVisible = false
                            }
                    case .patterns:
                        PatternsView(currentContent: $currentContent, addMode: $addMode, currentPattern: $currentPattern).frame(maxWidth: .infinity, maxHeight: .infinity) .onAppear {
                                editMode = false
                                addMode = false
                                editModeVisible = false
                                addIconVisible = true
                            }
                case .pattern_detail:
                    PatternDetailView(editMode: $editMode, pattern: $currentPattern, currentContent: $currentContent).frame(maxWidth: .infinity, maxHeight: .infinity).onAppear {
                            editMode = false
                            addMode = false
                            editModeVisible = true
                            addIconVisible = false
                        }
                    case .stash:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity).onAppear {
                                editMode = false
                                addMode = false
                                editModeVisible = false
                                addIconVisible = false
                            }
                    case .wips:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity).onAppear {
                                editMode = false
                                addMode = false
                                editModeVisible = false
                                addIconVisible = false
                            }
                    case .stitches:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity).onAppear {
                                editMode = false
                                addMode = false
                                editModeVisible = false
                                addIconVisible = false
                            }
                    case .wishlist:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity).onAppear {
                                editMode = false
                                addMode = false
                                editModeVisible = false
                                addIconVisible = false
                            }
                    case .statistics:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity).onAppear {
                                editMode = false
                                addMode = false
                                editModeVisible = false
                                addIconVisible = false
                            }
                    case .achievements:
                        NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity).onAppear {
                                editMode = false
                                addMode = false
                                editModeVisible = false
                                addIconVisible = false
                            }
                case .timeline:
                    NothingHereYetView().frame(maxWidth: .infinity, maxHeight: .infinity).onAppear {
                            editMode = false
                            addMode = false
                            editModeVisible = false
                            addIconVisible = false
                        }
                case .settings:
                    SettingsView(settings: $settings).frame(maxWidth: .infinity, maxHeight: .infinity).onAppear {
                            editMode = false
                            addMode = false
                            editModeVisible = false
                            addIconVisible = false
                        }
                }
            }
            
            SideMenuView(
                isShowing: $presentSideMenu,
                content: AnyView(SideMenuContentView(presentSideMenu: $presentSideMenu, currentContent: $currentContent))
            )
        } .onAppear {
            if let data = UserDefaults.standard.data(forKey: "settings"),
               let decoded = try? JSONDecoder().decode(Settings.self, from: data) {
                settings = decoded
            } else {
                if let encoded = try? JSONEncoder().encode(Settings(appearance: .system, language: .en)) {
                    UserDefaults.standard.set(encoded, forKey: "settings")
                }
            }
        } .preferredColorScheme(settings.appearance.colorScheme)
    }
}

#Preview {
    MainView()
}
