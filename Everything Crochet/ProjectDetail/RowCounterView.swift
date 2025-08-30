import SwiftUI

struct RowCounterView: View {
    
    @Binding var progress: [[Int]]
    @Binding var parts: [String]
    @Binding var editMode: Bool

    @State var newPart: String = ""
    @State var currentPart: Int = 0
    @State var currentPartString: String = ""
    @State var totalProgress: [Int] = [0, 0]
    
    func updateProgress() {
        totalProgress = [0, 0]
        progress.forEach {
            totalProgress[0] += $0[0];
            totalProgress[1] += $0[1]
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack () {
                Text("Row counter for:").font(.title2).padding(.vertical, 8)
               
                Picker("Selected part", selection: $currentPartString) {
                    ForEach(parts, id: \.self) { part in
                       Text(part)
                   }
                }
                
                Spacer()
            }
            
            ProgressView(progress: $progress, currentPart: $currentPart, editMode: $editMode)
            
            if editMode {
                VStack {
                    HStack () {
                        Text("Parts manager:").font(.title2).padding(.vertical, 8)
                        
                        Spacer()
                    }
                    HStack {
                        ScrollView (.horizontal) {
                            HStack (alignment: .top) {
                                if parts.count > 0 {
                                    ForEach(Array(parts.enumerated()), id: \.offset) { index, part in
                                        TagView(tagName: part, color: Color.lighter, editMode: $editMode, info: false)
                                    }.padding(.bottom)
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("New part:")
                        TextField("eg. Body", text: $newPart) .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button {
                            newPart = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        Button {
                            if newPart.count > 0 {
                                parts.append(newPart)
                                print("Add tag '" + newPart + "'")
                                progress.append([0, 0])
                            }
                            
                            newPart = ""
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    }
                }
            }
            
            if !editMode {
                HStack(spacing: 40) {
                    Spacer()
                    Button {
                        if progress[currentPart][0] > 0 {
                            print("Update row counter for " + parts[currentPart] + " by -1")
                            progress[currentPart][0] -= 1
                        }
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.appSecondary)
                    }
                    
                    Text("\(progress[currentPart][0])")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .frame(minWidth: 80)
                    
                    Button {
                        if progress[currentPart][0] < progress[currentPart][1] {
                            print("Update row counter for " + parts[currentPart] + " by +1")
                            progress[currentPart][0] += 1
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.appSecondary2)
                    }
                    Spacer()
                } .padding(.top)
            }       
        }.frame(maxWidth: .infinity) .padding(.bottom) .onAppear(perform: updateProgress) .onAppear(perform: { currentPartString = parts[currentPart] }) .onChange(of: progress, { updateProgress()}) .onChange(of: currentPartString, { currentPart = parts.firstIndex(of: currentPartString) ?? 0})
    }
}

#Preview {
    RowCounterView(progress: .constant([[5, 20], [6, 28]]), parts: .constant(["Body", "Head"]), editMode: .constant(true))
}
