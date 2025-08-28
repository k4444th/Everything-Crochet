import SwiftUI

struct SideMenuView: View {
    
    @Binding var isShowing: Bool
    
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    
    var body: some View {
            ZStack() {
                if (isShowing) {
                    Color.white
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowing.toggle()
                        }
                    content
                        .transition(edgeTransition)
                        .background(
                            Color.clear
                        )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            // .ignoresSafeArea()
            .animation(.easeInOut, value: isShowing)
        }
}
