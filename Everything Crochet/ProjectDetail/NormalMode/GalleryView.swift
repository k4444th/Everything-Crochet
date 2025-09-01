import PhotosUI
import SwiftUI

struct GalleryView: View {

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
                Text("Gallery:").font(.title2).padding(.vertical, 8) .padding(.horizontal)
                Spacer()
            }
            if images.count > 0 {
                ScrollView (.horizontal) {
                    HStack (spacing: 16) {
                        ForEach(Array(images.enumerated()), id: \.offset) { index, imageUrl in
                            Button() {
                                selectedImageIndex = index
                            } label: {
                                let data = imageUrl
                                if let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 150)
                                        .frame(width: 150)
                                        .clipped()
                                }
                            }
                        }
                    }.padding(.horizontal)
                }
            }
            else {
                VStack () {
                    Text("Your project gallery is empty.")
                    Text("Start capturing your progress!")
                        .padding(.bottom)
                    PhotosPicker(selection: $selectedItem) {
                        Text("Add your first progress photo") .padding(12) .tint(Color.lighter) .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.appPrimary)
                        )
                    } .onChange(of: selectedItem) { oldItem, newItem in
                        Task {
                            guard let newItem else { return }
                            if let data = try? await newItem.loadTransferable(type: Data.self) {
                                images.append(data)
                            }
                        }
                    }
                }.padding(.horizontal)
            }
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
    GalleryView(images: .constant([].compactMap { $0 }), selectedImageIndex: 0, showFullScreen: false)
}
