import SwiftUI

struct PatternDetailView: View {
    
    @Binding var editMode: Bool
    @Binding var pattern: Pattern
    @Binding var currentContent: MainContent
    
    func updatePatternInUserDefaults() {
        var patterns: [Pattern] = []
        if let data = UserDefaults.standard.data(forKey: "patterns"),
           let decoded = try? JSONDecoder().decode([Pattern].self, from: data) {
            patterns = decoded
        }
        
        print(patterns)
        
        if pattern.name.count > 0 {
            if let index = patterns.firstIndex(where: { $0.id == pattern.id }) {
                patterns[index] = pattern
            }
        }
        else {
            if let index = patterns.firstIndex(where: { $0.id == pattern.id }) {
                patterns.remove(at: index)
            }
            currentContent = .patterns
        }

        if let encoded = try? JSONEncoder().encode(patterns) {
            UserDefaults.standard.set(encoded, forKey: "patterns")
        }
    }
    
    var body: some View {
        VStack {
            if let data = pattern.previewImage,
               let uiImage = UIImage(data: data) {
                ZStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .clipped()
                }
            } else {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .overlay(Text("No Image"))
                }
            }

            VStack {
                HStack {
                    Text(pattern.name).font(.title).padding(.horizontal) .padding(.top)
                    Spacer()
                }
                
                if pattern.tags.count > 0 {
                    TagsView(tags: $pattern.tags)
                }
                
                VStack () {
                    switch pattern.type {
                        case .written:
                            WrittenPatternView(text: $pattern.writtenPattern)
                        case .image:
                            Text("Image pattern")
                            Spacer()
                        case .pdf:
                            Text("PDF pattern")
                        Spacer()
                    }
                }.padding(.horizontal)
            }
            
            NotesView(text: $pattern.notes) .padding(.horizontal)
        }.onChange(of: pattern) { updatePatternInUserDefaults() }
    }
}

#Preview {
    PatternDetailView(editMode: .constant(false), pattern: .constant(Pattern(
        id: 0,
        name: "Tunesische Karo-Decke",
        type: .written,
        previewImage: Data(),
        tags: ["Decke", "Tunesisch Häkeln"],
        notes: "",
        pdfPattern: Data(),
        imagePattern: [],
        writtenPattern: ""
    )), currentContent: .constant(.pattern_detail))
}
