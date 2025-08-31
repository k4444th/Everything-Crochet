import SwiftUI

struct PartsEditModeView: View {
    @Binding var progress: [[Int]]
    @Binding var parts: [String]
    
    @State var editMode: Bool = true
    @State var showError: [Bool] = []
    @State var tempProgress: [[Int]] = []
    @State var newPart: String = ""
    
    // Vereinfachte Focus-States pro TextField-Typ
    @FocusState private var newPartFocused: Bool
    @FocusState private var currentRowFocusedIndex: Int?
    @FocusState private var totalRowsFocusedIndex: Int?
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func bindingForTempProgress(row: Int, column: Int) -> Binding<Int> {
        Binding<Int>(
            get: {
                guard tempProgress.indices.contains(row),
                      tempProgress[row].indices.contains(column) else { return 0 }
                return tempProgress[row][column]
            },
            set: { newValue in
                guard tempProgress.indices.contains(row),
                      tempProgress[row].indices.contains(column) else { return }
                tempProgress[row][column] = newValue
            }
        )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Parts:").font(.title2).padding(.vertical, 8)
            
            FlowLayoutView(items: parts, spacing: 8) { part in
                TagView(tagName: part, color: Color.lighter, editMode: $editMode, info: false)
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
                    tempProgress.append([0, 0])
                    showError.append(false)
                    newPartFocused = false
                    print("Add part '\(newPart)'")
                    newPart = ""
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
                            value: bindingForTempProgress(row: index, column: 0),
                            formatter: formatter
                        )
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($currentRowFocusedIndex, equals: index)
                        
                        Button {
                            tempProgress[index][0] = progress[index][0]
                            currentRowFocusedIndex = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        
                        Button {
                            currentRowFocusedIndex = nil
                            if tempProgress[index][0] > tempProgress[index][1] {
                                showError[index] = true
                            } else {
                                showError[index] = false
                                progress[index][0] = tempProgress[index][0]
                                print("Update progress of part \(parts[index]) to [\(progress[index][0]), \(progress[index][1])]")
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
                            value: bindingForTempProgress(row: index, column: 1),
                            formatter: formatter
                        )
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($totalRowsFocusedIndex, equals: index)
                        
                        Button {
                            tempProgress[index][1] = progress[index][1]
                            totalRowsFocusedIndex = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        
                        Button {
                            totalRowsFocusedIndex = nil
                            if tempProgress[index][0] > tempProgress[index][1] {
                                showError[index] = true
                            } else {
                                showError[index] = false
                                progress[index][1] = tempProgress[index][1]
                                print("Update progress of part \(parts[index]) to [\(progress[index][0]), \(progress[index][1])]")
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
                            TagView(tagName: "Current row must be ≤ total rows!", color: Color.appSecondary, editMode: $editMode, info: true)
                            Spacer()
                        }
                    }
                }.padding(.bottom)
            }
        }
        .onAppear {
            tempProgress = progress
            showError = Array(repeating: false, count: parts.count)
        }
        .onChange(of: progress) { tempProgress = progress }
    }
}

#Preview {
    PartsEditModeView(
        progress: .constant([[5, 20], [6, 28]]),
        parts: .constant(["Body", "Head"])
    )
}
