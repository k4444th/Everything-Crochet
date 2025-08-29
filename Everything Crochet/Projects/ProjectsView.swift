import SwiftUI

struct ProjectsView: View {
    
    @Binding var currentContent: MainContent
    
    var body: some View {
        ScrollView {
            VStack {
                ProjectCardView(currentContent: $currentContent)
            }
            .padding()
        }
    }
}

#Preview {
    ProjectsView(currentContent: .constant(.contents))
}
