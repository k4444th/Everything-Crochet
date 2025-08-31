import PhotosUI
import SwiftUI

struct GalleryEditModeView: View {

    @Binding var images: [URL]
    
    @State var selectedItem: PhotosPickerItem?
    @State var selectedImageIndex: Int?
    @State var showFullScreen = false
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {  return }
            guard let inputImage = UIImage(data: imageData) else { return }
            print("Import image to gallery:")
            print(inputImage)
        }
    }
    
    var body: some View {
        VStack() {
            HStack {
                Text("Gallery:").font(.title2)
                Spacer()
            }
            let columns = [
                GridItem(.fixed(120)),
                GridItem(.fixed(120)),
                GridItem(.fixed(120))
            ]
            
            LazyVGrid(columns: columns, spacing: 25) {
                PhotosPicker(selection: $selectedItem) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.appSecondary2)
                }
                
                ForEach(Array(images.enumerated()), id: \.offset) { index, imageUrl in
                    Button() {
                        selectedImageIndex = index
                    } label: {
                        ZStack {
                            AsyncImage(url: imageUrl) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable() .scaledToFill() .frame(width: 100, height: 100) .clipped()
                                }
                            }
                            Button {
                                print("Delete image at index " + String(index))
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                    }
                }
            }  .onChange(of: selectedItem, loadImage)

        }.frame(maxWidth: .infinity, alignment: .leading) .padding(.bottom)
        
        .fullScreenCover(isPresented: Binding(
            get: { selectedImageIndex != nil },
            set: { if !$0 { selectedImageIndex = nil } }
        )) {
            if let index = selectedImageIndex {
                ZStack(alignment: .topTrailing) {
                    Color.black.ignoresSafeArea()
                    VStack {
                        Spacer()
                        AsyncImage(url: images[index]) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .ignoresSafeArea()
                            }
                        }
                        Spacer()
                    }
                    Button(action: { selectedImageIndex = nil }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
        }

    }
}

#Preview {
    GalleryEditModeView(images: .constant([URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"), URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"), URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"), URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"), URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"), URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"), URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png")].compactMap { $0 }), selectedImageIndex: 0, showFullScreen: false)
}
