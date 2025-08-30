import SwiftUI

struct ProgressView: View {
    
    @Binding var progress: [Int]
    
    var body: some View {
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
        }.padding(.bottom)
    }
}

#Preview {
    ProgressView(progress: .constant([5, 20]))
}
