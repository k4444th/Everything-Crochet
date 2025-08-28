import SwiftUI

struct ContentCardView: View {
    
    @State var content: MainContent
    @State var iconName: String
    @Binding var currentContent: MainContent
    
    var body: some View {
        Button() {
            currentContent = content
            print(content)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25) .stroke(Color.accent, lineWidth: 1) .foregroundColor(.clear) .frame(width: 155, height: 155)
                
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
