import SwiftUI

@main
struct Everything_CrochetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(presentSideMenu: .constant(false))
        }
    }
}
