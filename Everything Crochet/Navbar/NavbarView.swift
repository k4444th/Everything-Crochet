import SwiftUI

struct NavbarView: View {
    
    @Binding var presentSideMenu: Bool
    @Binding var currentContent: MainContent
    
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
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("\(currentContent)".uppercased()).foregroundColor(Color.background).fontWeight(.bold)
                    
                    // Text("Everything Crochet").foregroundColor(Color.background).font(.title2)
                    
                    // Image(systemName: "scissors") .imageScale(.large) .foregroundColor(Color.background)
                    
                    Spacer()
                }.frame(maxHeight: .infinity, alignment: .top)
            }
            .padding()
        }.padding(.horizontal) .frame(height: 50) .background(Color.appPrimary)
    }
}

#Preview {
    NavbarView(presentSideMenu: .constant(false), currentContent: .constant(.contents))
}
