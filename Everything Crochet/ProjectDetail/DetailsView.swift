import SwiftUI

struct DetailsView: View {
    
   @State var techniques = ["Tunesian Crochet"]
    @State var deadline = "01.01.2026"
    @State var yarn = ["Lisa Premium (Gründl)"]
    @State  var difficulty = "medium"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Details:").font(.title2).padding(.vertical, 8)
            
            HStack {
                Text("Techniques:")
                ForEach(techniques, id: \.self) { technique in
                    Text(technique)
                }
            }
            
            HStack {
                Text("Deadline:")
                Text(deadline)
            }
            
            HStack {
                Text("Yarn:")
                ForEach(yarn, id: \.self) { yarnType in
                    Text(yarnType)
                }
            }
            
            HStack {
                Text("Difficulty:")
                Text(difficulty)
            }
            
        }.padding() .frame(maxWidth: .infinity, alignment: .leading)
    }
}
