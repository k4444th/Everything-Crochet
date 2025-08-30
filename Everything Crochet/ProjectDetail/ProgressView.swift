import SwiftUI

struct ProgressView: View {
    @State var dummy: Bool = false
    @State var showError: Bool = false
    @Binding var progress: [Int]
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
                            .frame(width: geo.size.width * CGFloat(Double(progress[0]) / Double(progress[1])), height: 10)
                    }
                }.frame(height: 10) .frame(maxWidth: .infinity)
                
                Text(String(progress[0]) + "/" + String(progress[1]))
            }
            
            if editMode {
                
                VStack () {
                    HStack {
                        Text("Current row:")
                        TextField("eg. 1", value: $tempProgress[0], formatter: formatter) .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button {
                            tempProgress[0] = progress[0]
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        Button {
                            if tempProgress[0] > tempProgress[1] {
                                showError = true
                            }
                            else {
                                showError = false
                                progress[0] = tempProgress[0]
                                print("Update progress to [" + String(progress[0]) + "," + String(progress[0]) + "]")
                            }
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    }
                    
                    HStack {
                        Text("Total rows:")
                        TextField("eg. 10", value: $tempProgress[1], formatter: formatter) .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button {
                            tempProgress[1] = progress[1]
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        Button {
                            if tempProgress[0] > tempProgress[1] {
                                showError = true
                            }
                            else {
                                showError = false
                                progress[1] = tempProgress[1]
                                print("Update progress to [" + String(progress[0]) + "," + String(progress[0]) + "]")
                            }
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    }                }
                
                if showError {
                    TagView(tagName: "Current row must be smaller or than or equal to total rows!", color: Color.appSecondary, editMode: $dummy, info: true)
                    
                }
            }
            
        }.padding(.bottom) .onChange(of: editMode) { oldValue, newValue in
            if newValue {
                tempProgress = progress
            }
        }

    }
}

#Preview {
    ProgressView(progress: .constant([5, 20]), editMode: .constant(true))
}
