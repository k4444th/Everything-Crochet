import PhotosUI
import SwiftUI

struct GalleryView: View {

    @Binding var images: [URL]
    @Binding var editMode: Bool
    
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
                Text("Gallery:").font(.title2).padding(.vertical, 8) .padding(.horizontal)
                Spacer()
            }
            if images.count > 0 {
                ScrollView (.horizontal) {
                    HStack (spacing: 16) {
                        if editMode {
                            PhotosPicker(selection: $selectedItem) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.appSecondary2)
                                    .padding(.trailing)
                            } .padding(.leading) .onChange(of: selectedItem, loadImage)
                            
                        }
                        ForEach(Array(images.enumerated()), id: \.offset) { index, imageUrl in
                            Button() {
                                selectedImageIndex = index
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
                    }
                }.padding(.horizontal)
            }
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
    GalleryView(images: .constant([URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"), URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png"), URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/1362px-Placeholder_view_vector.svg.png")].compactMap { $0 }), editMode: .constant(true), selectedImageIndex: 0, showFullScreen: false)
}
