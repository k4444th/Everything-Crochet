import PhotosUI
import SwiftUI

struct GalleryEditModeView: View {

    @Binding var images: [Data]
    
    @State var selectedItem: PhotosPickerItem?
    @State var selectedImageIndex: Int?
    @State var showFullScreen = false
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {  return }
            guard let inputImage = UIImage(data: imageData) else { return }
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
                } .onChange(of: selectedItem) { oldItem, newItem in
                    Task {
                        guard let newItem else { return }
                        if let data = try? await newItem.loadTransferable(type: Data.self) {
                            images.append(data)
                        }
                    }
                }
                
                ForEach(Array(images.enumerated()), id: \.offset) { index, imageUrl in
                    Button() {
                        selectedImageIndex = index
                    } label: {
                        ZStack {
                            let data = imageUrl
                            if let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 100)
                                    .frame(width: 100)
                                    .clipped()
                            }

                            Rectangle() .fill(Color.accent) .opacity(0.3) .frame(width: 100, height: 100)
                            Button {
                                images.remove(at: index)
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.lighter)
                                    .padding()
                            }
                        }
                    }
                }
            }  .onChange(of: selectedItem, loadImage)

        }.frame(maxWidth: .infinity, alignment: .leading) .padding(.bottom)
        
        .fullScreenCover(isPresented: Binding(
            get: { selectedImageIndex != nil && selectedImageIndex! < images.count },
            set: { if !$0 { selectedImageIndex = nil } }
        )) {
            if let index = selectedImageIndex, index < images.count {
                ZStack(alignment: .topTrailing) {
                    Color.black.ignoresSafeArea()
                    VStack {
                        Spacer()
                        if let uiImage = UIImage(data: images[index]) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        Spacer()
                    }
                    Button(action: {
                        selectedImageIndex = nil
                    }) {
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
    GalleryEditModeView(images: .constant([]), selectedImageIndex: 0, showFullScreen: false)
}
