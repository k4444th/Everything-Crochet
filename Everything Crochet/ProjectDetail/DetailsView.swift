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
            
            HStack {
                VStack (alignment: .center, spacing: 8) {
                    Image(systemName: "hammer")
                            .imageScale(.large)
                            .foregroundColor(Color.accent).padding(.bottom, 8)
                    
                    Image(systemName: "scissors")
                            .imageScale(.large)
                            .foregroundColor(Color.accent).padding(.bottom, 8)
                    
                    Image(systemName: "clock")
                            .imageScale(.large)
                            .foregroundColor(Color.accent).padding(.bottom, 8)
                    
                    Image(systemName: "calendar")
                        .imageScale(.large)
                        .foregroundColor(Color.accent).padding(.bottom, 8)
                }
                
                VStack (alignment: .leading, spacing: 8) {
                    Text("Techniques: \(techniques.joined(separator: ", "))").padding(.bottom, 8)
                    
                    Text("Yarn: \(yarn.joined(separator: ", "))").padding(.bottom, 8).padding(.bottom, 8)
                    
                    Text("Start: " + startdate + " - End: " + enddate).padding(.bottom, 8)
                    
                    Text("Deadline: " + deadline).padding(.bottom, 8)
                }
            }
            
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}
