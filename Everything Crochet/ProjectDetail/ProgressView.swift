import SwiftUI

struct ProgressView: View {
    @State var showError: Bool = false
    @Binding var progress: [Int]
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
                        .fill(Color.background)
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.appPrimary)
                            .frame(width: geo.size.width * CGFloat(Double(progress[0]) / Double(progress[1])), height: 10)
                    }
                }.frame(height: 10) .frame(maxWidth: .infinity)
                
                Text(String(progress[0]) + "/" + String(progress[1]))
            }
            
            if editMode  {
                VStack () {
                    HStack {
                        Text("Current Row:")
                        TextField("eg. 1", value: $progress[0], formatter: formatter) .textFieldStyle(RoundedBorderTextFieldStyle()) .onChange(of: progress[0]) {
                                if progress[0] > progress[1] {
                                    showError = true
                                }
                                else {
                                    showError = false
                                }
                        }
                    }
                    HStack {
                        Text("Total Rows:")
                        TextField("eg. 10", value: $progress[1], formatter: formatter) .textFieldStyle(RoundedBorderTextFieldStyle()) .onChange(of: progress[1]) {
                                if progress[1] < progress[0] {
                                    showError = true
                                }
                                else {
                                    showError = false
                                }
                        }
                    }
                }
                if showError {
                    TagView(tagName: "Current row must be smaller or than or equal to total rows!", color: Color.appSecondary)
                }
            }
            
        }.padding(.bottom)
    }
}

#Preview {
    ProgressView(progress: .constant([5, 20]), editMode: .constant(true))
}
