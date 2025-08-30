import SwiftUI

struct ProjectCardView: View {
    
    @Binding var currentContent: MainContent
    
    var body: some View {
        Button{
            currentContent = .project_detail
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.lighter) .foregroundColor(.clear)
                
                VStack (spacing: 0) {
                    AsyncImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhnqZpQ6W8HhJCtjrathdXW4djHWyp9itXIg&s")) { phase in
                        if let image = phase.image {
                            image
                                .resizable() .scaledToFill() .frame(width: 350, height: 150) .clipped()
                        }
                    }
                    
                    Text("Checkered Tunesian Blanket").padding()
                }
            }.frame(width: 350, height: 200) .cornerRadius(20)
        }.padding()
    }
}

#Preview {
    ProjectCardView(currentContent: .constant(.contents))
}
