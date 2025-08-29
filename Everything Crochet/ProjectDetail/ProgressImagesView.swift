import SwiftUI

struct ProgressImagesView: View {
    
    @State private var selectedImageURL: String = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"
    @State private var showFullScreen = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Galery:").font(.title2).padding(.vertical, 8) .padding(.horizontal)
            
            ScrollView (.horizontal) {
                HStack (spacing: 16) {
                    Button() {
                        selectedImageURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"
                        showFullScreen = true
                    } label: {
                        AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable() .scaledToFill() .frame(width: 150, height: 150) .clipped()
                            }
                        }
                    }
                }.padding(.horizontal)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
        
        .fullScreenCover(isPresented: $showFullScreen) {
            ZStack(alignment: .topTrailing) {
                Color.black.ignoresSafeArea()
                VStack {
                    Spacer()
                    AsyncImage(url: URL(string: selectedImageURL)) { phase in
                        if let image = phase.image {
                            image
                                .resizable() .scaledToFit() .ignoresSafeArea()
                        }
                    }
                    Spacer()
                }
                Button(action: { showFullScreen = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    ProgressImagesView()
}
