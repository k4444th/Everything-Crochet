import SwiftUI

struct RowCounterView: View {
    
    @Binding var progress: [[Int]]
    @Binding var parts: [String]
    @Binding var currentPart: Int
    
    @State var currentPartString: String = ""

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
            
            ProgressView(progress: $progress, currentPart: $currentPart)
            
            HStack(spacing: 40) {
                Spacer()
                Button {
                    if progress[currentPart][0] > 0 {
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
            
        }.frame(maxWidth: .infinity) .padding(.bottom) .onAppear(perform: { currentPartString = parts[currentPart] }).onChange(of: currentPartString, { currentPart = parts.firstIndex(of: currentPartString) ?? 0})
    }
}

#Preview {
    RowCounterView(progress: .constant([[5, 20], [6, 28]]), parts: .constant(["Body", "Head"]), currentPart: .constant(0))
}
