import PhotosUI
import SwiftUI

struct PatternsView: View {
    @AppStorage("patterns") private var patternData: Data?
    
    @Binding var currentContent: MainContent
    @Binding var addMode: Bool
    @Binding var currentPattern: Pattern
    
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    
    @State var showError: Bool = false
    
    @State var newPattern: Pattern = Pattern(
        id: 0,
        name: "",
        previewImage: Data(),
        tags: [],
        techniques: "",
        notes: "",
        pattern: Data()
    )
    
    func decodePatterns(from data: Data?) -> [Pattern] {
        guard let data = data else { return [] }
        do {
            return try JSONDecoder().decode([Pattern].self, from: data)
        } catch {
            return []
        }
    }

    func createPattern() {
        if newPattern.name.count > 0 {
            var patterns: [Pattern] = []
            if let patternData,
               let decoded = try? JSONDecoder().decode([Pattern].self, from: patternData) {
                patterns = decoded
            }

            newPattern.id = (patterns.map { $0.id }.max() ?? -1) + 1

            if let selectedItem {
                Task {
                    if let data = try? await selectedItem.loadTransferable(type: Data.self) {
                        newPattern.previewImage = data

                        patterns.append(newPattern)
                        
                        if let encoded = try? JSONEncoder().encode(patterns) {
                            patternData = encoded
                        }

                        resetNewPattern()
                    }
                }
                return
            }

            patterns.append(newPattern)
            if let encoded = try? JSONEncoder().encode(patterns) {
                patternData = encoded
            }

            resetNewPattern()
        }
        else {
            showError = true
        }
    }

    private func resetNewPattern() {
        newPattern = Pattern (
            id: 0,
            name: "",
            previewImage: nil,
            tags: [],
            techniques: "",
            notes: "",
            pattern: Data(),
        )
    }
    
    var body: some View {
        if addMode {
            VStack (alignment: .leading) {
                HStack{
                    Text("Create pattern").font(.title)
                    Spacer()
                } .padding(.bottom)
                
                HStack {
                    Text("Pattern name:")
                    TextField("eg. My first amigurumi", text: $newPattern.name) .textFieldStyle(RoundedBorderTextFieldStyle())

                }
                
                if showError {
                    HStack {
                        Spacer()
                        if Locale.current.language.languageCode?.identifier == "en" {
                            TagView(tagName: "Pattern name cannot be emty!", color: Color.appSecondary, editMode: .constant(false), info: true, onDelete:{  })
                        }
                        else {
                            TagView(tagName: "Der Name der Anleitung darf nicht leer sein!", color: Color.appSecondary, editMode: .constant(false), info: true, onDelete: { })
                        }
                        
                        Spacer()
                    }
                }
                
                Text("Details:").font(.title2).padding(.vertical, 8)
                
                HStack {
                    Text("Pattern type:")
                    Picker("PatternType", selection: $newPattern.type) {
                        ForEach(PatternType.allCases, id: \.self) { type in
                            Text(type.name).tag(type)
                        }
                    }
                    Spacer()
                } .padding(.bottom)
                
                HStack{
                    Text("Preview image:").font(.title2)
                    Spacer()
                } .padding(.bottom)
                
                VStack {
                    HStack {
                        PhotosPicker(selection: $selectedItem) {
                            Text("Pick a photo")
                        }  .onChange(of: selectedItem) { oldValue, newValue in
                            if let newValue {
                                Task {
                                    if let data = try? await newValue.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        selectedImage = uiImage
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    
                    if let uiImage = selectedImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 100) .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                } .padding(.bottom)
                
                HStack {
                    Spacer()
                    Button {
                        if newPattern.name.count > 0 {
                            addMode = false
                        }
                    
                        createPattern()
                    } label: {
                        Text("Create new pattern")
                            .padding(12)
                            .tint(Color.lighter)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.appPrimary)
                            )
                    }
                    Spacer()
                }
                Spacer()
            }.padding()
        }
        else {
            ScrollView {
                VStack {
                    let decodedPatterns = decodePatterns(from: patternData)

                    if !decodedPatterns.isEmpty {
                           ForEach(decodedPatterns, id: \.id) { pattern in
                               PatternCardView(
                                   currentContent: $currentContent,
                                   pattern: .constant(pattern),
                                   currentPattern: $currentPattern
                               )
                           }
                       } else {
                        Button {
                            addMode = true
                        } label: {
                            Text("Create your first pattern!")
                                .padding(12)
                                .tint(Color.lighter)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.appPrimary)
                                )
                        }.padding()
                    }
                } .padding()
            }
        }
    }
}

#Preview {
    PatternsView(currentContent: .constant(.contents), addMode: .constant(false), currentPattern: .constant(Pattern()))
}
