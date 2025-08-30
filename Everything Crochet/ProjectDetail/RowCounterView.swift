import SwiftUI

struct RowCounterView: View {
    
    @Binding var progress: [Int]
    @Binding var editMode: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack () {
                Text("Row counter:").font(.title2).padding(.vertical, 8)
                Spacer()
            }
            
            ProgressView(progress: $progress, editMode: $editMode).padding(.horizontal)
            
            HStack(spacing: 40) {
                Spacer()
                Button {
                    if progress[0] > 0 {
                        print("Update row counter by -1")
                        progress[0] -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.appSecondary)
                }
                
                Text("\(progress[0])")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .frame(minWidth: 80)
                
                Button {
                    print("Update row counter by +1")
                    progress[0] += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.appSecondary2)
                }
                Spacer()
            }
            
        }.frame(maxWidth: .infinity) .padding(.bottom)
    }
}

#Preview {
    RowCounterView(progress: .constant([5, 20]), editMode: .constant(false))
}
