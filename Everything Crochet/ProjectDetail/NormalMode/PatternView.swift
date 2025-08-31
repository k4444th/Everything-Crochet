import PDFKit
import SwiftUI

struct PatternView: View {
    
    var pdfUrl: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pattern:").font(.title2).padding(.vertical, 8)
            
            PDFKitView(pdfUrl: pdfUrl)
            
        }.frame(maxWidth: .infinity, alignment: .leading) .padding(.bottom)
    }
}

#Preview {
    PatternView(pdfUrl: "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf")
}
