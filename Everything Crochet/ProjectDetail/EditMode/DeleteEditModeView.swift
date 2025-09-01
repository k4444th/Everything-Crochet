import SwiftUI

struct DeleteEditModeView: View {
    
    @Binding var project: Project
    
    var body: some View {
        Button {
            project = Project(id: project.id)
        } label: {
            Text("Delete project") .padding(12) .tint(Color.lighter) .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.appSecondary)
            )
        }
    }
}

#Preview {
    DeleteEditModeView(project: .constant(Project()))
}
