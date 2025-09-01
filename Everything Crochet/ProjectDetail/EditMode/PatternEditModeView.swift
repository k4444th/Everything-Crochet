import SwiftUI

struct PatternEditModeView: View {
    var pdfUrl: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pattern:").font(.title2).padding(.vertical, 8)
            
            if pdfUrl.count > 0 {
                ZStack {
                    PDFKitView(pdfUrl: pdfUrl)
                    Rectangle() .fill(Color.accent) .opacity(0.3) .frame(maxWidth: .infinity) .frame(maxHeight: .infinity)
                    Button {
                        print("Edit project pattern")
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.lighter)
                            .padding()
                    }
                }
            }
            
            else {
                VStack () {
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
                } .frame(maxWidth: .infinity)
            }
            
        }.frame(maxWidth: .infinity, alignment: .leading) .padding(.bottom)
    }
}

#Preview {
    PatternEditModeView(pdfUrl: "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf")
}

