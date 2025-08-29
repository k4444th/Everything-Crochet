import SwiftUI

struct ProjectCardView: View {
    var body: some View {
        Button() {} label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25) .foregroundColor(.clear) .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.background))
                
                VStack {
                    AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png")) { phase in
                        if let image = phase.image {
                            image
                                .resizable() .scaledToFill() .frame(width: 350, height: 150) .clipped()
                        }
                    }
                    
                    Text("Project Name").padding()
                }
            }.frame(width: 350, height: 200) .cornerRadius(25)
        }.padding()
    }
}

#Preview {
    ProjectCardView()
}
