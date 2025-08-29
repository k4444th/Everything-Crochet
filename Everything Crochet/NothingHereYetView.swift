import SwiftUI

struct NothingHereYetView: View {
    var body: some View {
        VStack {
            Image(systemName: "tortoise") .imageScale(.large) .foregroundColor(Color.accentColor).padding(.bottom, 16)
            
            Text("Nothing here yet, sorry :(")
        }
    }
}

#Preview {
    NothingHereYetView()
}

