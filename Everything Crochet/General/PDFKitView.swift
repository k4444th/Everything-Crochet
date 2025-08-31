import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let pdfUrl: String

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true

        // PDF asynchron laden
        if let url = URL(string: pdfUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                   let document = PDFDocument(data: data) {
                    DispatchQueue.main.async {
                        pdfView.document = document
                    }
                }
            }
        }

        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}
