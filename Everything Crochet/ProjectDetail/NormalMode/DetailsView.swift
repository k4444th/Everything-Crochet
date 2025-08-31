import SwiftUI

struct DetailsView: View {
    
    @Binding var techniques: String
    @Binding var startdate: String
    @Binding var enddate: String
    @Binding var deadline: String
    @Binding var yarn: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Details:").font(.title2).padding(.vertical, 8)
            
            let columns = [
                GridItem(.fixed(30), alignment: .top),
                GridItem(.flexible(),  alignment: .top)
            ]
            
            LazyVGrid(columns: columns, alignment: .leading) {
                Image(systemName: "hammer")
                        .imageScale(.large)
                        .foregroundColor(Color.accent).padding(.bottom, 8)
                
                HStack {
                    Text("Techniques:").padding(.bottom, 8)
                    Text(techniques).padding(.bottom, 8)
                    Spacer()
                }
                
                Image(systemName: "scissors")
                        .imageScale(.large)
                        .foregroundColor(Color.accent).padding(.bottom, 8)
                
                HStack {
                    Text("Yarn:").padding(.bottom, 8)
                    Text(yarn).padding(.bottom, 8)
                    Spacer()
                }
                
                Image(systemName: "clock")
                        .imageScale(.large)
                        .foregroundColor(Color.accent).padding(.bottom, 8)
                VStack {
                    HStack {
                        Text("Startdate:").padding(.bottom, 8)
                        Text(startdate).padding(.bottom, 8)
                        Spacer()
                    }
                    HStack {
                        Text("Enddate:").padding(.bottom, 8)
                        Text(enddate).padding(.bottom, 8)
                        Spacer()
                    }
                }
               
                
                Image(systemName: "calendar")
                    .imageScale(.large)
                    .foregroundColor(Color.accent).padding(.bottom, 8)
                
                HStack {
                    Text("Deadline:").padding(.bottom, 8)
                    Text(deadline).padding(.bottom, 8)
                    Spacer()
                }
            }
        }.frame(maxWidth: .infinity, alignment: .leading) .padding(.bottom)
    }
}


#Preview {
    DetailsView(techniques: .constant("Tunesian Crochet"), startdate: .constant("21.05.2025"), enddate: .constant("-"), deadline: .constant("15.3.2026"), yarn: .constant("Gründl Lisa Premium"))
}
