import SwiftUI

struct ProgressView: View {
    @Binding var progress: [[Int]]
    @Binding var currentPart: Int
    @State var tempProgress: [Int] = [0,0]
    
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
        }
    }
}

#Preview {
    ProgressView(progress: .constant([[5, 20], [36, 60]]), currentPart: .constant(0))
}
