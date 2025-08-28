import SwiftUI

struct NavbarView: View {
    
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button  {
                        presentSideMenu.toggle()
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                            .foregroundColor(Color.background)
                    }
                    Spacer()
                }
            }
            .padding()
            
            VStack {
                HStack {
                    Spacer()
                    Text("Everything Crochet").foregroundColor(Color.background)
                    Spacer()
                }.frame(maxHeight: .infinity, alignment: .top)
            }
            .padding()
        }.padding(.horizontal) .frame(height: 50) .background(Color.accent)
    }
}

#Preview {
    NavbarView(presentSideMenu: .constant(false))
}
