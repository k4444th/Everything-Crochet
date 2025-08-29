import SwiftUI

struct ContentCardView: View {
    
    @State var content: MainContent
    @State var iconName: String
    @Binding var currentContent: MainContent
    
    var body: some View {
        Button() {
            currentContent = content
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25) .foregroundColor(.clear) .frame(width: 155, height: 155) .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.background))
                
                VStack {
                    Spacer()
                    
                    Image(systemName: iconName)
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    
                    Spacer()
                    
                    Text("\(content)".uppercased())
                    
                    Spacer()
                }
            }
        }
    }
}
