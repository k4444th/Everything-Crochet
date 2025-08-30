import SwiftUI

struct ProgressView: View {
    @State var dummy: Bool = false
    @State var showError: Bool = false
    @Binding var progress: [[Int]]
    @Binding var currentPart: Int
    @State var tempProgress: [Int] = [0,0]
    @Binding var editMode: Bool
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    var body: some View {
        VStack {
            HStack {
                ZStack (alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.lighter)
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.appPrimary)
                            .frame(width: geo.size.width * CGFloat(progress[currentPart][0]) / CGFloat(progress[currentPart][1]), height: 10)
                    }
                }
                .frame(height: 10)
                .frame(maxWidth: .infinity)
                
                Text("\(progress[currentPart][0]) / \(progress[currentPart][1])")
            }
            
            if editMode {
                VStack {
                    HStack {
                        Text("Current row:")
                        TextField("eg. 1", value: $tempProgress[0], formatter: formatter)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button { tempProgress[0] = progress[currentPart][0] } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        Button {
                            if tempProgress[0] > tempProgress[1] {
                                showError = true
                            } else {
                                showError = false
                                progress[currentPart][0] = tempProgress[0]
                                print("Update progress of part " + String(currentPart) + " to [\(progress[currentPart][0]), \(progress[currentPart][1])]")
                            }
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    }
                    
                    HStack {
                        Text("Total rows:")
                        TextField("eg. 10", value: $tempProgress[1], formatter: formatter)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button { tempProgress[1] = progress[currentPart][1] } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        Button {
                            if tempProgress[0] > tempProgress[1] {
                                showError = true
                            } else {
                                showError = false
                                progress[currentPart][1] = tempProgress[1]
                                print("Update progress of part " + String(currentPart) + " to [\(progress[currentPart][0]), \(progress[currentPart][1])]")
                            }
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    }
                } .padding(.top)
                
                if showError {
                    TagView(tagName: "Current row must be smaller or equal to total rows!", color: Color.appSecondary, editMode: $dummy, info: true)
                }
            }
        } .onChange(of: editMode, { tempProgress = progress[currentPart] }) .onChange(of: currentPart, { tempProgress = progress[currentPart] })
    }
}

#Preview {
    ProgressView(progress: .constant([[5, 20], [36, 60]]), currentPart: .constant(0), editMode: .constant(true))
}
