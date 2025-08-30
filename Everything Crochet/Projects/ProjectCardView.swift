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
                
                VStack {
                    AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png")) { phase in
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
