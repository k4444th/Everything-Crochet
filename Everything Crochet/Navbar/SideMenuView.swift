import SwiftUI

struct SideMenuView: View {
    
    @Binding var isShowing: Bool
    
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    
    var body: some View {
            ZStack() {
                if (isShowing) {
                    Color.accent
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowing.toggle()
                        }
                    content
                        .transition(edgeTransition)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .animation(.easeInOut, value: isShowing)
        }
}

#Preview {
    SideMenuView(isShowing: .constant(true), content: AnyView(SideMenuContentView(presentSideMenu: .constant(false), currentContent: .constant(.contents))))
}
