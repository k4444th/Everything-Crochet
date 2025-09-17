import SwiftUI

struct ContentView: View {
    
    @Binding var presentSideMenu: Bool
    @Binding var currentContent: MainContent
    
    var body: some View {
        VStack {
            ScrollView {
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(MainContent.allCases.dropFirst(), id: \.self) { contentName in
                        
                        var iconName: String {
                            switch contentName {
                                case .contents: return "book"
                                case .projects: return "folder"
                                case .project_detail: return ""
                                case .patterns: return "square.grid.2x2"
                                case .pattern_detail: return ""
                                case .stash: return "shippingbox"
                                case .stitches: return "scissors"
                                case .wishlist: return "heart"
                                case .statistics: return "chart.bar"
                                case .achievements: return "star"
                                case .settings: return "gearshape"
                            }
                        }
                        
                        if contentName.title.first != "(" && contentName.title.last != ")" {
                            ContentCardView(
                                content: contentName,
                                iconName: iconName,
                                currentContent: $currentContent
                            )
                        }
                    }
                }
                .padding()
                .padding(.vertical, 16)
            }
        }
    }
}

#Preview {
    ContentView(presentSideMenu: .constant(false), currentContent: .constant(.contents))
}
