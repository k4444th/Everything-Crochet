import SwiftUI

struct ContentView: View {
    
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        VStack {
            Text("Content View")
        }
        .padding()
    }
}

#Preview {
    ContentView(presentSideMenu: .constant(false))
}
