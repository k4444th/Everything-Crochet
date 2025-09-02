import SwiftUI

struct PatternCardView: View {
    @Binding var currentContent: MainContent
    @Binding var pattern: Pattern
    @Binding var currentPattern: Pattern
    
    var body: some View {
        Button{
            currentContent = .pattern_detail
            currentPattern = pattern
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.lighter) .foregroundColor(.clear)
                
                VStack (spacing: 0) {
                    if let data = pattern.previewImage,
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 150)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 350, height: 150)
                            .overlay(
                                Text("No Image")
                                    .foregroundColor(.secondary)
                            )
                    }

                    
                    Text(pattern.name).padding()
                }
            }.frame(width: 350, height: 200) .cornerRadius(20)
        }.padding()
    }
}

#Preview {
    PatternCardView(currentContent: .constant(.contents), pattern: .constant(Pattern()), currentPattern: .constant(Pattern()))
}
