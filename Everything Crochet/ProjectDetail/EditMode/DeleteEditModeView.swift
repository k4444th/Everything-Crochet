import SwiftUI

struct DeleteEditModeView: View {
    var body: some View {
        Button {
            print("Delete project")
        } label: {
            Text("Delete project") .padding(12) .tint(Color.lighter) .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.appSecondary)
            )
        }
    }
}

#Preview {
    DeleteEditModeView()
}
