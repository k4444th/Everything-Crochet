import SwiftUI

struct NavbarView: View {
    
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button  {
                    presentSideMenu.toggle()
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }
                Spacer()
                Text("Everything Crochet")
                Spacer()
            }.frame(maxHeight: .infinity, alignment: .top)
        }
        .padding()
    }
}
