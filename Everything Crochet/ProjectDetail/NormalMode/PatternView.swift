import PDFKit
import SwiftUI

struct PatternView: View {
    
    var pdfUrl: String
    
    var body: some View {
        if pdfUrl.count > 0 {
            VStack(alignment: .leading) {
                Text("Pattern:").font(.title2).padding(.vertical, 8)
                
                PDFKitView(pdfUrl: pdfUrl)
            } .frame(width: .infinity, height: 550) .padding(.bottom)
        }

        else {
            VStack (alignment: .center) {
                HStack {
                    Text("Pattern:").font(.title2).padding(.vertical, 8)
                    Spacer()
                }
                Text("This project has no pattern yet")
                    .padding(.bottom)
                Button {
                    print("Add pattern to project")
                } label: {
                    Text("Add pattern") .padding(12) .tint(Color.lighter) .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.appPrimary)
                    )
                }
            } .frame(width: .infinity, height: 100) .padding(.bottom)
        }
    }
}

#Preview {
    PatternView(pdfUrl: "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf")
}
