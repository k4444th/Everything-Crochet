import SwiftUI

struct RowCounterView: View {
    
    @Binding var row: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack () {
                Text("Row counter:").font(.title2).padding(.vertical, 8)
            }
            
            HStack(spacing: 40) {
                Button {
                    if row > 0 {
                        print("Update row counter by -1")
                        row -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.appSecondary)
                }
                
                Text("\(row)")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .frame(minWidth: 80)
                
                Button {
                    print("Update row counter by +1")
                    row += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.appSecondary2)
                }
            }
            
        }.frame(maxWidth: .infinity) .padding(.bottom)
    }
}

#Preview {
    RowCounterView(row: .constant(24))
}
