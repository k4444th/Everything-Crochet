import SwiftUI

struct DeleteEditModeView: View {
    
    @Binding var project: Project
    @State var showWarning: Bool = false
    
    var body: some View {
        VStack {
            if showWarning {
                if Locale.current.language.languageCode?.identifier == "en" {
                    TagView(tagName: "Are you sure you want to delete this project? It will be lost forever!", color: Color.appSecondary, editMode: .constant(false), info: true, onDelete: {  })
                }
                else {
                    TagView(tagName: "Bist du dir sicher, dass du dieses Projekt löschen willst? Es wird für immer verloren sein!", color: Color.appSecondary, editMode: .constant(false), info: true, onDelete: { })
                }
                HStack {
                    Button {
                        if showWarning {
                            project = Project(id: project.id)
                            showWarning = false
                        }
                        else {
                            showWarning = true
                        }
                        
                    } label: {
                        Text("Delete project") .padding(12) .tint(Color.accent) .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.lighter)
                        )
                    }
                    Button { showWarning = false } label: {
                        Text("Cancel") .padding(12) .tint(Color.lighter) .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.appSecondary)
                        )
                    }
                } .padding(.top)
            }
            else {
                Button {
                    if showWarning {
                        project = Project(id: project.id)
                        showWarning = false
                    }
                    else {
                        showWarning = true
                    }
                    
                } label: {
                    Text("Delete project") .padding(12) .tint(Color.accent) .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.lighter)
                    )
                }
            }
        }
    }
}

#Preview {
    DeleteEditModeView(project: .constant(Project()))
}
