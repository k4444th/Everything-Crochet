import SwiftUI

struct ProjectsView: View {
    var body: some View {
        ScrollView {
            VStack {
                ProjectCardView()
                ProjectCardView()
                ProjectCardView()
                ProjectCardView()
                ProjectCardView()
                ProjectCardView()
            }
            .padding()
        }
    }
}

#Preview {
    ProjectsView()
}
