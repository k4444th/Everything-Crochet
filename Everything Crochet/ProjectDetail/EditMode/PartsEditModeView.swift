import SwiftUI

struct PartsEditModeView: View {
    @Binding var progress: [[Int]]
    @Binding var parts: [String]
    
    @State var editMode: Bool = true
    @State var dontDelete: Bool = false
    @State var showError: [Bool] = []
    @State var newPart: String = ""
    
    @FocusState private var newPartFocused: Bool
    @FocusState private var currentRowFocusedIndex: Int?
    @FocusState private var totalRowsFocusedIndex: Int?
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func bindingForProgress(row: Int, column: Int) -> Binding<Int> {
        Binding<Int>(
            get: {
                guard progress.indices.contains(row),
                      progress[row].indices.contains(column) else { return 0 }
                return progress[row][column]
            },
            set: { newValue in
                guard progress.indices.contains(row),
                      progress[row].indices.contains(column) else { return }
                progress[row][column] = newValue
            }
        )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Parts:").font(.title2).padding(.vertical, 8)
            
            FlowLayoutView(items: parts, spacing: 8) { index, part  in
                TagView(tagName: part, color: Color.lighter, editMode: $editMode, info: false, onDelete: {
                        if parts.count > 1 {
                            parts.remove(at: index)
                        }
                        else {
                            dontDelete = true
                        }
                    })
            }
            
            if dontDelete {
                HStack {
                    Spacer()
                    if Locale.current.language.languageCode?.identifier == "en" {
                        TagView(tagName: "Your project must consist of at least one part!", color: Color.appSecondary, editMode: $editMode, info: true, onDelete: {  })
                    }
                    else {
                        TagView(tagName: "Dein projekt muss aus mindestens einem Teil bestehen!", color: Color.appSecondary, editMode: $editMode, info: true, onDelete: { })
                    }
                   
                    Spacer()
                }
            }
            
            HStack {
                Text("New part:")
                TextField("eg. Body", text: $newPart)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($newPartFocused)
                
                Button {
                    newPartFocused = false
                    newPart = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.appSecondary)
                }
                
                Button {
                    guard !newPart.isEmpty else { return }
                    parts.append(newPart)
                    progress.append([0, 0])
                    showError.append(false)
                    newPartFocused = false
                    newPart = ""
                    dontDelete = false
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.appSecondary2)
                }
            }
            .padding(.bottom)
            
            ForEach(parts.indices, id: \.self) { index in
                VStack(alignment: .leading) {
                    Text(parts[index]).font(.title3)

                    HStack {
                        Text("Current row:")
                        TextField(
                            "eg. 1",
                            value: bindingForProgress(row: index, column: 0),
                            formatter: formatter
                        )
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($currentRowFocusedIndex, equals: index)
                        
                        Button {
                            currentRowFocusedIndex = nil
                            if progress[index][0] > progress[index][1] {
                                showError[index] = true
                            } else {
                                showError[index] = false
                                progress[index][0] = progress[index][0]
                            }
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    }

                    HStack {
                        Text("Total rows:")
                        TextField(
                            "eg. 10",
                            value: bindingForProgress(row: index, column: 1),
                            formatter: formatter
                        )
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($totalRowsFocusedIndex, equals: index)
                        
                        Button {
                            totalRowsFocusedIndex = nil
                            if progress[index][0] > progress[index][1] {
                                showError[index] = true
                            } else {
                                showError[index] = false
                                progress[index][1] = progress[index][1]
                            }
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    }
                    
                    if showError.indices.contains(index), showError[index] {
                        HStack {
                            Spacer()
                            if Locale.current.language.languageCode?.identifier == "en" {
                                TagView(tagName: "Current row must be smaller or equal to total rows!", color: Color.appSecondary, editMode: $editMode, info: true, onDelete: {  })
                            }
                            else {
                                TagView(tagName: "Die aktuelle Reihe muss kleiner oder gleich der Gesamtreihenanzahl sein!", color: Color.appSecondary, editMode: $editMode, info: true, onDelete: { })
                            }
                           
                            Spacer()
                        }
                    }
                }.padding(.bottom)
            }
        }
        .onAppear {
            showError = Array(repeating: false, count: parts.count)
        }
    }
}

#Preview {
    PartsEditModeView(
        progress: .constant([[5, 20], [6, 28]]),
        parts: .constant(["Body", "Head"])
    )
}
