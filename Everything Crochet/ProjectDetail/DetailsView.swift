import SwiftUI

struct DetailsView: View {
    
    @Binding var techniques: [String]
    @Binding var startdate: String
    @Binding var enddate: String
    @Binding var deadline: String
    @Binding var yarn: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Details:").font(.title2).padding(.vertical, 8)
            
            let columns = [
                GridItem(.fixed(30)),
                GridItem(.flexible())
            ]
            
            LazyVGrid(columns: columns, alignment: .leading) {
                Image(systemName: "hammer")
                        .imageScale(.large)
                        .foregroundColor(Color.accent).padding(.bottom, 8)
                
                Text("Techniques: \(techniques.joined(separator: ", "))").padding(.bottom, 8)
                
                Image(systemName: "scissors")
                        .imageScale(.large)
                        .foregroundColor(Color.accent).padding(.bottom, 8)
                
                Text("Yarn: \(yarn.joined(separator: ", "))").padding(.bottom, 8).padding(.bottom, 8)
                
                Image(systemName: "clock")
                        .imageScale(.large)
                        .foregroundColor(Color.accent).padding(.bottom, 8)
                
                Text("Start: " + startdate + " - End: " + enddate).padding(.bottom, 8)
                
                Image(systemName: "calendar")
                    .imageScale(.large)
                    .foregroundColor(Color.accent).padding(.bottom, 8)
                
                Text("Deadline: " + deadline).padding(.bottom, 8)
            }
        }.frame(maxWidth: .infinity, alignment: .leading) .padding(.bottom)
    }
}


#Preview {
    DetailsView(techniques: .constant(["Tunesian Crochet"]), startdate: .constant("21.05.2025"), enddate: .constant("-"), deadline: .constant("15.3.2026"), yarn: .constant(["Gründl Lisa Premium"]))
}
