import SwiftUI

struct GalleryView: View {

    @Binding var images: [URL]
    
    @State var selectedImageIndex: Int = 0
    @State var showFullScreen = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Gallery:").font(.title2).padding(.vertical, 8) .padding(.horizontal)
            
            ScrollView (.horizontal) {
                HStack (spacing: 16) {
                    ForEach(Array(images.enumerated()), id: \.offset) { index, imageUrl in
                        Button() {
                            selectedImageIndex = index
                            showFullScreen = true
                        } label: {
                            AsyncImage(url: imageUrl) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable() .scaledToFill() .frame(width: 150, height: 150) .clipped()
                                }
                            }
                        }
                    }

                }.padding(.horizontal)
            }
        }.frame(maxWidth: .infinity, alignment: .leading) .padding(.bottom)
        
        .fullScreenCover(isPresented: $showFullScreen) {
            ZStack(alignment: .topTrailing) {
                Color.black.ignoresSafeArea()
                VStack {
                    Spacer()
                    AsyncImage(url: images[selectedImageIndex]) { phase in
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
