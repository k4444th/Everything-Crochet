import PDFKit
import SwiftUI

struct PatternView: View {
    
    @State var showPicker: Bool = false
    @Binding var patternData: Data?
    
    var body: some View {
        if let data = patternData, !data.isEmpty {
            VStack(alignment: .leading) {
                Text("Pattern:").font(.title2).padding(.vertical, 8)
                
                PDFKitView(pdfData: data)
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
                    showPicker = true
                } label: {
                    Text("Add pattern") .padding(12) .tint(Color.lighter) .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.appPrimary)
                    )
                }
            } .frame(height: 100) .frame(maxWidth: .infinity) .padding(.bottom)
                .fileImporter(
                    isPresented: $showPicker,
                    allowedContentTypes: [.pdf],
                    allowsMultipleSelection: false
                ) { result in
                    switch result {
                    case .success(let urls):
                        guard let url = urls.first else { return }

                        if url.startAccessingSecurityScopedResource() {
                            defer { url.stopAccessingSecurityScopedResource() }

                            let fileManager = FileManager.default
                            let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                            let destURL = docsURL.appendingPathComponent(url.lastPathComponent)

                            do {
                                if fileManager.fileExists(atPath: destURL.path) {
                                    try fileManager.removeItem(at: destURL)
                                }

                                try fileManager.copyItem(at: url, to: destURL)

                                let data = try Data(contentsOf: destURL)
                                patternData = data
                                print("PDF geladen, Größe: \(data.count) bytes")
                            } catch {
                                print("Fehler beim Kopieren oder Laden der PDF: \(error.localizedDescription)")
                            }

                        } else {
                            print("Keine Zugriffsrechte auf die ausgewählte Datei.")
                        }

                    case .failure(let error):
                        print("Fehler beim Import: \(error.localizedDescription)")
                    }
                }
        }
    }
}

#Preview {
    PatternView(patternData: .constant(Data()))
}
